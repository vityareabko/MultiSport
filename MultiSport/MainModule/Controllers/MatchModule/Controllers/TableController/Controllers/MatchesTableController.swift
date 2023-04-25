//
//  MatchesTableController.swift
//  MultiSport
//
//  Created by Витя Рябко on 10/04/23.
//

import UIKit

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
    
    // делаем запросы по ид лиги
    private func fetchFutureEvents(leagueID: LeagueID) {
        let request = NetworkManager.shared.request(with: .fixturesNext(next: self.countNext, leagueID: leagueID))
        guard let r = request else { return }
        
        requestEvents(with: r)
    }

    
    
//    // MARK: - API Reqeust Function
//    func fetchFixtures(_ response: [FixtureResponse], leagueTitle: String) {
//        var arrayFixtures = [SportFixture]()
//
//        // Создаем DispatchGroup для организации операций в группу
//        let dispatchGroup = DispatchGroup()
//
//        // Проходим по каждому элементу массива response с использованием цикла for-in
//        for fixtureResponse in response {
//            // Получаем дату матча из свойства date объекта Fixture
//            guard let date = dateFormatter.date(from: fixtureResponse.fixture.date) else {
//                continue
//            }
//
//            // Получаем названия команд из объектов Team
//            guard let homeTeamName = fixtureResponse.teams.home?.name,
//                  let awayTeamName = fixtureResponse.teams.away?.name else {
//                continue
//            }
//
//            // Получаем URL логотипов команд из объектов Team
//            guard let homeTeamLogoUrlString = fixtureResponse.teams.home?.logo,
//                  let awayTeamLogoUrlString = fixtureResponse.teams.away?.logo else {
//                continue
//            }
//
//            // Создаем объект SportFixture с использованием полученных данных
//            let fixture = SportFixture(teamHome: homeTeamName,
//                                       imageUrlHomeTeam: homeTeamLogoUrlString,
//                                       teamAway: awayTeamName,
//                                       imageUrlAwayTeam: awayTeamLogoUrlString,
//                                       matchDate: date)
//
//            // Добавляем операцию в DispatchGroup для загрузки логотипов команд
//            dispatchGroup.enter()
//            downloadTeamLogos(homeLogoUrlString: homeTeamLogoUrlString,
//                              awayLogoUrlString: awayTeamLogoUrlString) { homeTeamLogo, awayTeamLogo in
//
//                // После завершения загрузки логотипов команд, обновляем объект SportFixture и добавляем его в массив
//                fixture.teamHomeIcon = homeTeamLogo
//                fixture.teamAwayIcon = awayTeamLogo
//                arrayFixtures.append(fixture)
//
//                // Убираем операцию из DispatchGroup после ее завершения
//                dispatchGroup.leave()
//            }
//        }
//
//        // Запускаем замыкание после завершения всех операций в DispatchGroup
//        dispatchGroup.notify(queue: DispatchQueue.main) {
//            // Создаем словарь SportFixture сгруппированных по дате матча и сортируем его по ключу
//            let sportFixtureDictionary = arrayFixtures
//                .reduce(into: [String: [SportFixture]]()) { result, fixture in
//                    let key = dateFormatter.string(from: fixture.matchDate)
//                    result[key, default: []].append(fixture)
//                }
//                .sorted(by: { $0.key < $1.key })
//
//            // Создаем массив SportSection из словаря SportFixture и обновляем таблицу
//            let sportSections = sportFixtureDictionary.map { key, fixtures in
//                SportSection(title: key, items: fixtures)
//            }
//
//            self.matchesTableView.setData(model: sportSections)
//            self.matchesTableView.reloadData()
//        }
//    }
//
//    // Функция для загрузки логотипов команд
//    func downloadTeamLogos(homeLogoUrlString: String, awayLogoUrlString: String, completion: @escaping (UIImage?, UIImage?) -> Void) {
//        var homeTeamLogo: UIImage?
//        var awayTeamLogo: UIImage?
//
//        // Создаем DispatchGroup для организации операций в групп
//        let dispatchGroup = DispatchGroup()
//
//        // Добавляем операцию в DispatchGroup для загрузки логотипа домашней команды
//        dispatchGroup.enter()
//        GetImageRequest.shared.test(with: homeLogoUrlString) { image in
//            homeTeamLogo = image
//
//            // Убираем операцию из DispatchGroup после ее завершения
//            dispatchGroup.leave()
//        }
//
//        // Добавляем операцию в DispatchGroup для загрузки логотипа гостевой команды
//        dispatchGroup.enter()
//        GetImageRequest.shared.test(with: awayLogoUrlString) { image in
//            awayTeamLogo = image
//
//            // Убираем операцию из DispatchGroup после ее завершения
//            dispatchGroup.leave()
//        }
//
//        // Запускаем замыкание после завершения всех операций в DispatchGroup
//        dispatchGroup.notify(queue: DispatchQueue.main) {
//            completion(homeTeamLogo, awayTeamLogo)
//        }
//    }
    
    
    
    // [StatisticTypeValue]
    // [ [vopros, znachHome, znachAway] ]
    
                        
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
