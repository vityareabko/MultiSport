//
//  MatchesTableController.swift
//  MultiSport
//
//  Created by Витя Рябко on 10/04/23.
//

import UIKit

// TODO: - демонстрация №1

class MatchesTableController: UIViewController {
    
    // MARK: - UI Components
    private let matchesTableView = MatchesTableView()
    
    // этот масив будет передан для обновления обробработанных данных
    private var sections = [SportSection]()
    
    // это число возвращаемих item в response
    private var countNext = 5
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
        
        // делаем запросы и обновляем колекцию с данными
//        loadFututreEvents()
        print("это таблица с секциями")
    }
    
    // обработка запросв в асинхроном режиме
    private func loadFututreEvents() {
        //let leagueIDs: [LeagueID] = [.premierLegue, .laLeague, .premierNational, .nation]
        let leagueIDs: [LeagueID] = [.premierLegue]
        Task {
            await withTaskGroup(of: Void.self, body: { group in
                for leagueID in leagueIDs {
                    group.addTask {
                        await self.fetchFutureEvents(leagueID: leagueID)
                    }
                }
            })
        }
    }
    
    // создаем url
    private func fetchFutureEvents(leagueID: LeagueID) {
        let request = NetworkManager.shared.request(with: .fixturesNext(next: self.countNext, leagueID: leagueID))
        guard let r = request else { return }
        
        requestEvents(with: r)
    }
                        
    // MARK: - API Result Function
    private func requestEvents(with url: URL) {
        NetworkDataFetch.shared.fetchFutureFootballMatchesResponse(urlRequest: url) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                guard let dataResponse = data.response else {
                    return
                }
                
                processResponse(dataResponse)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    // обработка response
    private func processResponse(_ response: [Response]) {
        var arrayFixtures = [SportFixture]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let leagueName = response.first?.league.name else { return }
        
        for item in response{
            // получаем нужные данные
            guard let date = dateFormatter.date(from: item.fixture.date),
                  let homeTeamName = item.teams.home?.name,
                  let awayTeamName = item.teams.away?.name,
                  let urlStringLogoHomeTeam = item.teams.home?.logo,
                  let urlStringLogoAwayTeam = item.teams.away?.logo else {
                return
            }
            
            let fixture = SportFixture(teamHome: homeTeamName,
                                              imageUrlHomeTeam: urlStringLogoHomeTeam,
                                              teamAway: awayTeamName,
                                              imageUrlAwayTeam: urlStringLogoAwayTeam,
                                              matchDate: date)
            
            downloadAndUpdateTeamLogo(fixture: fixture) { updatedFixture in
                arrayFixtures.append(updatedFixture)
                
                if arrayFixtures.count == response.count {
                    self.addSportSectionToTableView(leagueTitle: leagueName, fixtures: arrayFixtures)
                }
            }
        }
    }
    
    
    // скачивания изображений
    private func downloadAndUpdateTeamLogo(fixture: SportFixture, complition: @escaping (SportFixture) -> Void) {
        Task{
            
            let logoTeamHome = await GetImageRequest.shared.test(with: fixture.imageUrlHomeTeam)
            let logoTeamAway = await GetImageRequest.shared.test(with: fixture.imageUrlAwayTeam)
            
            DispatchQueue.main.async {
                var updatedFixture = fixture
                updatedFixture.teamHomeIcon = logoTeamHome
                updatedFixture.teamAwayIcon = logoTeamAway
                
                complition(updatedFixture)
            }
        }
    }
    
    private func addSportSectionToTableView(leagueTitle: String, fixtures: [SportFixture]) {
        let section = SportSection(title: leagueTitle, items: fixtures)
        sections.append(section)
        matchesTableView.setData(model: sections)
        matchesTableView.reloadData()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .clear
        
        self.view.addSubview(matchesTableView)
        matchesTableView.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Extensions
extension MatchesTableController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            matchesTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            matchesTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            matchesTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            matchesTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        ])
    }
}
