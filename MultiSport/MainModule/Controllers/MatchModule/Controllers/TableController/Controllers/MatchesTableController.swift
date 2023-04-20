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
    private let arrayRequests = [URL?]()
    private var sections = [SportSection]()
    
    


    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
        
        // Fixtures to come
        let item1 = NetworkManager.shared.request(with: .fixtures(leagueID: .laLeague))
        let item2 = NetworkManager.shared.request(with: .fixtures(leagueID: .nation))

        let commingMatches = [item1, item2]

        for request in commingMatches {
            guard let r = request else { return }
            self.requestEvents(with: r)
            break
        }
        
        
    }
    
    
    // MARK: - API Reqeust Function
    private func requestEvents(with url: URL) {
        NetworkDataFetch.shared.fetchResponse(urlRequest: url) { [self] result, error in

            // пытаюсь получить модель нашей структуры
            if let model = result {
                var arrayFixtures = [SportFixture]()
                
                guard let response = model.response else { return }
               
                response.forEach { item in
                    guard let teamHomeName = item.teams.home?.name,
                          let teamAwayName = item.teams.away?.name else {
                        return
                    }

               
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

                    guard let date = dateFormatter.date(from: item.fixture.date) else {
                        return
                    }

                    guard let urlStringLogoTeamHome = item.teams.home?.logo,
                          let urlStringLogoTeamAway = item.teams.away?.logo else {
                        return
                    }
                    
                    
                    var itemFixtures = SportFixture(teamHome: teamHomeName, teamHomeIcon: nil, teamAway: teamAwayName, teamAwayIcon: nil, matchDate: date)
                    
                    GetImageRequest.shared.getImage(urlString: [urlStringLogoTeamHome, urlStringLogoTeamAway]) { result in
                        switch result {
                        case .success(let images):
                            itemFixtures.teamHomeIcon = images[0]
                            itemFixtures.teamAwayIcon = images[1]
                            print(images[0])
                            print(images[1])
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }

                    arrayFixtures.append(itemFixtures)
                    
                }

                guard let titleSection = response.first?.league.name else {
                    return
                }



                let s = SportSection(title: titleSection, items: arrayFixtures)
                self.sections.append(s)
                
                // TODO: - это часть должно быть в viewDidLoad - но она там не работает
                matchesTableView.setData(model: sections)
                matchesTableView.reloadData()

            }
        }
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
