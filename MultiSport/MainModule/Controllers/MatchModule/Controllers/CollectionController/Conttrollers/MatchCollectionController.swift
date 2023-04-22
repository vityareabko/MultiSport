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
    private var arrayTeams = [TeamModel]()
    
    override func loadView() {
        super.loadView()
//        let item1 = NetworkManager.shared.request(with: .fixtures(next: nil, last: countLast, leagueID: .premierLegue))
//        let item2 = NetworkManager.shared.request(with: .fixtures(next: nil, last: countLast, leagueID: .laLeague))
//        let item3 = NetworkManager.shared.request(with: .fixtures(next: nil, last: countLast, leagueID: .premierNational))
//        let item4 = NetworkManager.shared.request(with: .fixtures(next: nil, last: countLast, leagueID: .nation))
        
//        let arrayRequests = [item1]
        
//        for request in arrayRequests {
//            guard let r = request else { return }
//            self.requestPastEvents(with: r)
//        }
        
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
    }
    
    // MARK: - API Result Function
    private func requestPastEvents(with url: URL) {
        
        NetworkDataFetch.shared.fetchPastFootballMatchesResponse(urlRequest: url) { [weak self] result, error in

            // пытаюсь получить модель нашей структуры
            
            guard let self = self,
                  let model = result,
                  let response = model.response else {
                return
            }

            processResponse(response)
            
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
        return TeamModel(teamName: team.name, teamURLLogo: team.logo)
    }

    // скачиваем изображения и возвращаем обновленую модель c изображениями
    func downloadAndUpdateTeamLogo(for team: TeamModel) {
        Task {
            let logo = await GetImageRequest.shared.test(with: team.teamURLLogo)
            
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
