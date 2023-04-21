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
    
    


    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
        
        // Fixtures to come
        let item1 = NetworkManager.shared.request(with: .fixtures(leagueID: .laLeague))
        let item2 = NetworkManager.shared.request(with: .fixtures(leagueID: .nation))
        let item3 = NetworkManager.shared.request(with: .fixtures(leagueID: .premierLegue))
        let item4 = NetworkManager.shared.request(with: .fixtures(leagueID: .premierNational))
        
        
        let commingMatches = [item1, item2, item3, item4]
        

        for request in commingMatches {
            guard let r = request else { return }
            self.requestEvents(with: r)
        }
        
        

    }


    
                        
    // MARK: - API Reqeust Function
    private func requestEvents(with url: URL) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        // масив хранит в себе все о дате и команд соревнований
        var arrayFixtures = [SportFixture]()
        
        var leagueTitle: String = ""
        
        
        
        NetworkDataFetch.shared.fetchResponse(urlRequest: url) { result, error in
            
            // пытаюсь получить модель нашей структуры
            if let model = result {
                
                guard let response = model.response else { return }
                
                // получили названия лиги
                leagueTitle = response.first?.league.name ?? "Error"
                
                //  массив будет повторятся 3 = так как в указаниях next = 3
                response.forEach { item in
                    // получили дату события
                    
                    guard let date = dateFormatter.date(from: item.fixture.date) else {
                        return
                    }
                    
                    // получили имена команд
                    guard let homeTeamName = item.teams.home?.name,
                          let awayTeamName = item.teams.away?.name else {
                        return
                    }
                    
                   
                    
                    guard let urlStringLogoHomeTeam = item.teams.home?.logo,
                          let urlStringLogoAwayTeam = item.teams.away?.logo else {
                        return
                    }
                    
                    var fixture = SportFixture(teamHome: homeTeamName, imageUrlHomeTeam: urlStringLogoHomeTeam, teamAway: awayTeamName, imageUrlAwayTeam: urlStringLogoAwayTeam, matchDate: date)
                   
                    // получаю изображения логотипов команд
                    
                    Task {
                        
                        let a = await GetImageRequest.shared.test(with: urlStringLogoHomeTeam)
                        let b = await GetImageRequest.shared.test(with: urlStringLogoAwayTeam)
                        
                        
                        
                        print(urlStringLogoHomeTeam)
                        print(urlStringLogoAwayTeam)
                        
                        
                        DispatchQueue.main.async {
                            
                            fixture.teamHomeIcon = a
                            fixture.teamAwayIcon = b
                            
                            arrayFixtures.append(fixture)
                            if arrayFixtures.count == response.count {
                                let s = SportSection(title: leagueTitle, items: arrayFixtures)
                                self.sections.append(s)
                                self.matchesTableView.setData(model: self.sections)
                                self.matchesTableView.reloadData()
                                
                            }
                        }
                        
                    }
                }
        
                
               
               
                    
//                    let s = SportSection(title: leagueTitle, items: arrayFixtures)
//                    sections.append(s)
//
//                    self.matchesTableView.setData(model: sections)
//                    self.matchesTableView.reloadData()
                    
                
                
                
                
                
                
//                    GetImageRequest.shared.getImages(urlString: [urlStringLogoHomeTeam, urlStringLogoAwayTeam]) { result in
//                        switch result {
//                        case .success(let images):
//                            fixture.teamHomeIcon = images[0]
//                            fixture.teamAwayIcon = images[1]
//
//                        case .failure(let error):
//                            print(error.localizedDescription)
//                        }
//                    }
                    
                    
                
                    
                    
                    
                        
                    
                
                
                
            }
        }
        
        
    }
            
            // пытаюсь получить модель нашей структуры
//            if let model = result {
//                var arrayFixtures = [SportFixture]()
//
//                guard let response = model.response else { return }
//
//                guard let titleSection = response.first?.league.name else {
//                    return
//                }
//
//                response.forEach { item in
//
//                    guard let teamHomeName = item.teams.home?.name,
//                          let teamAwayName = item.teams.away?.name else {
//                        return
//                    }
//
//
//
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//
//                    guard let date = dateFormatter.date(from: item.fixture.date) else {
//                        return
//                    }
//
//                    guard let urlStringLogoTeamHome = item.teams.home?.logo,
//                          let urlStringLogoTeamAway = item.teams.away?.logo else {
//                        return
//                    }
//
//
//                    //                    var itemFixtures = SportFixture(teamHome: teamHomeName, teamHomeIcon: urlStringLogoTeamHome, teamAway: teamAwayName, teamAwayIcon: urlStringLogoTeamAway, matchDate: date)
//                    //                        GetImageRequest.shared.getImages(urlString: [urlStringLogoTeamHome, urlStringLogoTeamAway]) { result in
//                    //                            switch result {
//                    //                            case .success(let images):
//                    //                                itemFixtures.teamHomeIcon = images[0]
//                    //                                itemFixtures.teamAwayIcon = images[1]
//                    //
//                    //                            case .failure(let error):
//                    //                                print(error.localizedDescription)
//                    //                            }
//                    //                        }
//
//                    DispatchQueue.main.async {
//                        Task {
//                            var itemFixtures = SportFixture(teamHome: teamHomeName, teamHomeIcon: nil, teamAway: teamAwayName, teamAwayIcon: nil, matchDate: date)
//
//                            let a = await GetImageRequest.shared.test(with: urlStringLogoTeamHome)
//                            let b = await GetImageRequest.shared.test(with: urlStringLogoTeamAway)
//
//                            itemFixtures.teamHomeIcon = a
//                            itemFixtures.teamAwayIcon = b
//
//                            arrayFixtures.append(itemFixtures)
//
//
//
//
//                            let s = SportSection(title: titleSection, items: arrayFixtures)
//                            self.sections.append(s)
//
//
//                            // TODO: - это часть должно быть в viewDidLoad - но она там не работает
//                            matchesTableView.setData(model: sections)
//                            matchesTableView.reloadData()
//                        }
//                    }
//                }
//            }
//        }
//    }
    
    
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
