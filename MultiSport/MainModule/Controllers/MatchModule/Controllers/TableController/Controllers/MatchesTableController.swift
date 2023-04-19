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
    
    private var logoTeam = UIImageView(imageName: "asdasdasdasdas")
    
    
    private var testLabel = UILabel(text: "testlabe", textColor: .white, font: .gothamBold24())

    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
        
        // Fixtures to come
        // TODO: - requests
//        let item1 = NetworkManager.shared.request(with: .fixtures(leagueID: .laLeague))
//        let item2 = NetworkManager.shared.request(with: .fixtures(leagueID: .nation))
//
//        let commingMatches = [item1, item2]
//
//        for request in commingMatches {
//            guard let r = request else { return }
//            self.requestEvents(with: r)
//        }
        
        
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

                    print(item)
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

                    guard let date = dateFormatter.date(from: item.fixture.date) else {
                        return
                    }

                    guard let urlStringLogoTeamHome = item.teams.home?.logo,
                          let urlStringLogoTeamAway = item.teams.away?.logo else {
                        return
                    }
//
                    getImage(urlString: urlStringLogoTeamAway) // меняем logo team
//                  let logoTeamHome = getImage(urlString: urlStringLogoTeamHome)
                    

                    let itemFixtures = SportFixture(teamHome: teamHomeName, teamHomeIcon: logoTeam.image, teamAway: teamAwayName, teamAwayIcon: logoTeam.image, matchDate: date)
                    
//                    let itemFixtures = SportFixture(teamHome: teamHomeName, teamHomeIcon: nil, teamAway: teamAwayName, teamAwayIcon: nil, matchDate: date)

                    arrayFixtures.append(itemFixtures)
                }

                guard let titleSection = response.first?.league.name else {
                    return
                }



                let s = SportSection(title: titleSection, items: arrayFixtures)
                self.sections.append(s)
                
                setDataCell(model: sections)
                matchesTableView.reloadData()

            }
        }
    }
    
    // MARK: - SetData in Table cells
    private func setDataCell(model: [SportSection]) {
        matchesTableView.setData(model: model)
    }
    
    // MARK: - RequestGetImage
    private func getImage(urlString: String) -> Void{
        GetImageRequest.shared.getImage(urlString: urlString) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    // TODO: - не присваевается изображения ?????
                    guard let img = UIImage(data: data) else {return}
                    self.logoTeam.image = img
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
 
        
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .clear
        
        self.view.addSubview(matchesTableView)
        self.view.addSubview(testLabel)
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
            
            
            testLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            testLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
        ])
    }
}
