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
    
    /* это для будущих динамичных констрейнтов(при скролле будем менять multiplier) */
    private var logoMainTeamWidthConstraint: NSLayoutConstraint?
    private var logoMainTeamHeightConstraint: NSLayoutConstraint?

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
        
        matchesTeamTable.statisticMatchDelegate = self
        matchesTeamTable.changeConstrainDelegate = self
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
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extensions
extension MatchesTeamController {
    private func setConstraints() {
        /* это для того чтобы потом небыло конфликта когда меняем коефициент этих констрейнтов */
        logoMainTeamWidthConstraint = logoMainTeam.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: matchesTeamTable.logoMainTeamInitialWidth)
        logoMainTeamHeightConstraint = logoMainTeam.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: matchesTeamTable.logoMainTeamInitialWidth)
        logoMainTeamWidthConstraint?.isActive = true
        logoMainTeamHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            logoMainTeam.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 25),
            logoMainTeam.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            labelMainTeam.topAnchor.constraint(equalTo: logoMainTeam.bottomAnchor, constant: 15),
            labelMainTeam.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            labelMainTeam.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            labelMainTeam.heightAnchor.constraint(equalToConstant: 25),
            
            matchesTeamTable.topAnchor.constraint(equalTo: labelMainTeam.bottomAnchor, constant: 15),
            matchesTeamTable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            matchesTeamTable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            matchesTeamTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}


extension MatchesTeamController: ChangeConstrainProtocol {
    func changeContstraints(width: CGFloat, height: CGFloat) {
        if let widthConstraint = logoMainTeamWidthConstraint, let heightConstraint = logoMainTeamHeightConstraint {
            NSLayoutConstraint.deactivate([widthConstraint, heightConstraint])
        }
        
        if Int(height) == Int(matchesTeamTable.logoMainTeamMinimumWidth) {
            labelMainTeam.font = .gothamBold15()
        } else {
            labelMainTeam.font = .gothamBold24()
        }
        
        logoMainTeamWidthConstraint = logoMainTeam.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: width)
        logoMainTeamHeightConstraint = logoMainTeam.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: height)
        logoMainTeamWidthConstraint?.isActive = true
        logoMainTeamHeightConstraint?.isActive = true
        
        self.view.setNeedsUpdateConstraints()
        
    }
}


