//
//  MatchesTeamController.swift
//  MultiSport
//
//  Created by Витя Рябко on 19/04/23.
//

import UIKit

class MatchesTeamController: UIViewController {
    
    // MARK: - UI Components
    private let matchesTeamTable = MatchesTeamTable()
    
    private let logoMainTeam = UIImageView(imageName: "team1")
    private let labelMainTeam = UILabel(text: "Main Team", textColor: .systemGray5, font: .gothamBold24())

    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
        
        matchesTeamTable.statisticMatchDelegate = self
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .clear
        
        labelMainTeam.textAlignment = .center
        
        self.view.addSubview(logoMainTeam)
        self.view.addSubview(labelMainTeam)
        self.view.addSubview(matchesTeamTable)
        matchesTeamTable.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - StatisticMatchProtocol
extension MatchesTeamController : StatisticMatchProtocol {
    func presentStatistic() {
        let vc = StatisticMatchController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

// MARK: - Extensions
extension MatchesTeamController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoMainTeam.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 25),
            logoMainTeam.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logoMainTeam.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
            logoMainTeam.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
            
            labelMainTeam.topAnchor.constraint(equalTo: logoMainTeam.bottomAnchor, constant: 15),
            labelMainTeam.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            labelMainTeam.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            labelMainTeam.heightAnchor.constraint(equalToConstant: 25),
            
            matchesTeamTable.topAnchor.constraint(equalTo: labelMainTeam.bottomAnchor, constant: 60),
            matchesTeamTable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            matchesTeamTable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            matchesTeamTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
