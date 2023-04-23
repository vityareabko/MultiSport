//
//  MatchCollectionController.swift
//  MultiSport
//
//  Created by Витя Рябко on 09/04/23.
//

import UIKit

class MatchCollectionController: UIViewController {
    
    // MARK: - UI Components
    private let matchCollectionView = MatchCollectionView()
    
    // этот масив мы будем передавать для обновления интерфейса с обработанами уже данными
    private var arrayTeams = [TeamModel]()

    // это число возвращаемих item в response
    private let countLast = 5
    

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
        
        // делаем запросы и обновляем колекцию с данными
        loadPastEvents()
    }

    // обработка запросв в асинхроном режиме
    private func loadPastEvents() {
        // let leagueIDs: [LeagueID] = [.premierLegue, .laLeague, .premierNational, .nation]
        let leagueIDs: [LeagueID] = [.premierLegue]
        
        Task {
            await withTaskGroup(of: Void.self) { group in
                for leagueID in leagueIDs {
                    group.addTask {
                        await self.fetchPastEvents(for: leagueID)
                    }
                }
            }
            
            // Здесь мы можем обновить UI или выполнить другие действия после завершения всех запросов
            
        }
    }
    
    
    // делаем запросы по ид лиги
    private func fetchPastEvents(for leagueID: LeagueID) async {
        let request = NetworkManager.shared.request(with: .fixturesLast(last: countLast, leagueID: leagueID))
        guard let r = request else { return }
        self.requestPastEvents(with: r)
    }
    
    
    // MARK: - API Result Functions
    private func requestPastEvents(with url: URL) {
        NetworkDataFetch.shared.fetchPastFootballMatchesResponse(urlRequest: url) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                guard let dataResponse = data.response else {
                    return
                }
                self.processResponse(dataResponse)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // извлекаес все что нам нужно
    func processResponse(_ response: [PastMatchesResponse]) {
        for item in response {
            guard case let .pastMatchesAwayClass(awayTeam) = item.teams.away,
                  case let .pastMatchesAwayClass(homeTeam) = item.teams.home else {
                return
            }
            
            let homeTeamModel = createTeamModel(from: homeTeam)
            let awayTeamModel = createTeamModel(from: awayTeam)
            
            
            downloadAndUpdateTeamLogo(for: homeTeamModel)
            downloadAndUpdateTeamLogo(for: awayTeamModel)
            
        }
    }

    // создаем модель
    func createTeamModel(from team: PastMatchesAwayClass) -> TeamModel {
        return TeamModel(id: team.id, teamName: team.name, teamURLLogo: team.logo)
    }

    // скачиваем изображения и возвращаем обновленую модель c изображениями
    func downloadAndUpdateTeamLogo(for team: TeamModel) {
        Task {
            // скачяивания логотипа команды
            let logo = await GetImageRequest.shared.test(with: team.teamURLLogo)
            
            // код выполняется после скачивания
            DispatchQueue.main.async {
                var updatedTeam = team
                updatedTeam.teamLogo = logo
                if !self.arrayTeams.contains(updatedTeam) {
                    self.arrayTeams.append(updatedTeam)
                }
                self.matchCollectionView.setData(model: self.arrayTeams)
                self.matchCollectionView.reloadData()
            }
        }
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .clear
        
        self.view.addSubview(matchCollectionView)
        matchCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - set Delegate
    public func setDelegate(delagateVC: UIViewController){
        matchCollectionView.selectItemDelegate = delagateVC as? TeamMatchDetailedProtocol
    }
}

// MARK: - Extensions
extension MatchCollectionController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            matchCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            matchCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            matchCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
            matchCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
