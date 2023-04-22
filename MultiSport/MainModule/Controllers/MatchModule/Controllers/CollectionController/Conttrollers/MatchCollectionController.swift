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
    private let countLast = 5
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
        
        let item1 = NetworkManager.shared.request(with: .fixtures(next: nil, last: countLast, leagueID: .premierLegue))
        let item2 = NetworkManager.shared.request(with: .fixtures(next: nil, last: countLast, leagueID: .laLeague))
        let item3 = NetworkManager.shared.request(with: .fixtures(next: nil, last: countLast, leagueID: .premierNational))
        let item4 = NetworkManager.shared.request(with: .fixtures(next: nil, last: countLast, leagueID: .nation))
        
        let arrayRequests = [item1]
        
        for request in arrayRequests {
            guard let r = request else { return }
//            self.requestPastEvents(with: r)
        }
        
        
    }
    
    // MARK: - API Result Function
//    private func requestPastEvents(with url: URL) {
//
//        var arrayFixtures = [SportFixture]()
//
//        NetworkDataFetch.shared.fetchResponse(urlRequest: url) { [weak self] result, error in
//
//            // пытаюсь получить модель нашей структуры
////            if let model = result {
//            guard let self = self,
//                  let model = result,
//                  let response = model.response,
//                return
//            }
//
//
//            //  массив будет повторятся 3 = так как в указаниях next = 3
//            response.forEach { item in
//
//                // получаем нужные данные
//                guard let date = dateFormatter.date(from: item.fixture.date),
//                      let homeTeamName = item.teams.home?.name,
//                      let awayTeamName = item.teams.away?.name,
//                      let urlStringLogoHomeTeam = item.teams.home?.logo,
//                      let urlStringLogoAwayTeam = item.teams.away?.logo else {
//                    return
//                }
//
//
//                var fixture = SportFixture(teamHome: homeTeamName,
//                                           imageUrlHomeTeam: urlStringLogoHomeTeam,
//                                           teamAway: awayTeamName,
//                                           imageUrlAwayTeam: urlStringLogoAwayTeam,
//                                           matchDate: date)
//
//
//
//                // получаю изображения логотипов команд
//                Task {
//                    let a = await GetImageRequest.shared.test(with: urlStringLogoHomeTeam)
//                    let b = await GetImageRequest.shared.test(with: urlStringLogoAwayTeam)
//
//
//                    // код выполняется после завершения скачивания изображений
//                    DispatchQueue.main.async {
//
//                        fixture.teamHomeIcon = a
//                        fixture.teamAwayIcon = b
//
//                        // добаляем в масив после того как добавили скаченные изображения
//                        arrayFixtures.append(fixture)
//
//                        if arrayFixtures.count == response.count {
//                            self.addSportSectionToTableView(leagueTitle: leagueTitle, fixtures: arrayFixtures)
//                        }
//                    }
//                }
//
//            }
//        }
//    }
//
//    private func addSportSectionToTableView(leagueTitle: String, fixtures: [SportFixture]) {
//        let section = SportSection(title: leagueTitle, items: fixtures)
//        sections.append(section)
//        matchesTableView.setData(model: sections)
//        matchesTableView.reloadData()
//    }
//
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
