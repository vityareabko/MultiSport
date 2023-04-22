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
    
    private var sections = [SportSection]()
    
    

    override func loadView() {
        super.loadView()
        
        // Fixtures to come
        let item1 = NetworkManager.shared.request(with: .fixtures(next: 5, last: nil, leagueID: .laLeague))
//        let item2 = NetworkManager.shared.request(with: .fixtures(leagueID: .nation))
//        let item3 = NetworkManager.shared.request(with: .fixtures(leagueID: .premierLegue))
//        let item4 = NetworkManager.shared.request(with: .fixtures(leagueID: .premierNational))
        
        
//        let commingMatches = [item1, item2, item3, item4]
        
        let commingMatches = [item1]


        for request in commingMatches {
            guard let r = request else { return }
            self.requestEvents(with: r)
        }
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
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
    
    
                        
    // MARK: - API Result Function
    private func requestEvents(with url: URL) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        // масив хранит в себе все о дате и команд соревнований
        var arrayFixtures = [SportFixture]()

        NetworkDataFetch.shared.fetchResponse(urlRequest: url) { [weak self] result, error in

            // пытаюсь получить модель нашей структуры
//            if let model = result {
            guard let self = self,
                  let model = result,
                  let response = model.response,
                  let leagueTitle = response.first?.league.name else {
                return
            }
                        

            //  массив будет повторятся 3 = так как в указаниях next = 3
            response.forEach { item in
                
                // получаем нужные данные
                guard let date = dateFormatter.date(from: item.fixture.date),
                      let homeTeamName = item.teams.home?.name,
                      let awayTeamName = item.teams.away?.name,
                      let urlStringLogoHomeTeam = item.teams.home?.logo,
                      let urlStringLogoAwayTeam = item.teams.away?.logo else {
                    return
                }


                var fixture = SportFixture(teamHome: homeTeamName,
                                           imageUrlHomeTeam: urlStringLogoHomeTeam,
                                           teamAway: awayTeamName,
                                           imageUrlAwayTeam: urlStringLogoAwayTeam,
                                           matchDate: date)
                    
                   
                
                // получаю изображения логотипов команд
                Task {
                    let a = await GetImageRequest.shared.test(with: urlStringLogoHomeTeam)
                    let b = await GetImageRequest.shared.test(with: urlStringLogoAwayTeam)


                    // код выполняется после завершения скачивания изображений
                    DispatchQueue.main.async {

                        fixture.teamHomeIcon = a
                        fixture.teamAwayIcon = b

                        // добаляем в масив после того как добавили скаченные изображения
                        arrayFixtures.append(fixture)

                        if arrayFixtures.count == response.count {
                            self.addSportSectionToTableView(leagueTitle: leagueTitle, fixtures: arrayFixtures)
                        }
                    }
                }
                
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
