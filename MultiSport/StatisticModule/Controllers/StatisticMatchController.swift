//
//  StatisticMatchController.swift
//  MultiSport
//
//  Created by Витя Рябко on 19/04/23.
//

import UIKit

class StatisticMatchController: UIViewController {
    
    // MARK: - UI Components
    private let statisticMatchTableView = StatisticMatchTableView()
    
    private let labelMainTitle = UILabel(text: "STATISTICS", textColor: .specialOrangeColor, font: .gothamBold22())
    
    private let labelTeamNameHome = UILabel(text: "Milan", textColor: .systemGray5, font: .gothamBold15())
    private let labelTeamNameAway = UILabel(text: "Real Madrid", textColor: .systemGray5, font: .gothamBold15())
    private let labelScore = UILabel(text: "1 : 0", textColor: .specialOrangeColor, font: .gothamBold24())
    private let labelDate = UILabel(text: "Dec 19", textColor: .specialLight, font: .gothamBold13())
    
    private let logoTeamHome = UIImageView(imageName: "team1")
    private let logoTeamAway = UIImageView(imageName: "team2")
    
    
    private var stackViewFixture = UIStackView()
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .specialMainBaground
        
        // из extesion + UIViewController
        setNavigationBar()
        
        labelMainTitle.textAlignment = .center
        labelTeamNameAway.textAlignment = .center
        labelTeamNameHome.textAlignment = .center
        labelDate.textAlignment = .center
        labelScore.textAlignment = .center
        
        labelTeamNameAway.numberOfLines = 2
        labelTeamNameHome.numberOfLines = 2
        
        
        setStackView()
        
        self.view.addSubview(labelMainTitle)
        self.view.addSubview(stackViewFixture)
        
        self.view.addSubview(statisticMatchTableView)
        statisticMatchTableView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setStackView() {
        let stackViewTeamHome = UIStackView(arrangedSubviews: [logoTeamHome, labelTeamNameHome])
        stackViewTeamHome.axis = .vertical
        stackViewTeamHome.spacing = 5
        stackViewTeamHome.distribution = .equalSpacing
        
        let stackViewTeamAway = UIStackView(arrangedSubviews: [logoTeamAway, labelTeamNameAway])
        stackViewTeamAway.axis = .vertical
        stackViewTeamAway.spacing = 5
        stackViewTeamAway.distribution = .equalSpacing
        
        let stackViewScore = UIStackView(arrangedSubviews: [labelDate, labelScore])
        stackViewScore.axis = .vertical
        stackViewScore.spacing = 0
        stackViewScore.distribution = .fillEqually
       
    
        stackViewFixture = UIStackView(arrangedSubviews: [stackViewTeamHome, stackViewScore, stackViewTeamAway])
        stackViewFixture.axis = .horizontal
        stackViewFixture.spacing = 10
        stackViewFixture.distribution = .equalSpacing
        
 
        stackViewFixture.translatesAutoresizingMaskIntoConstraints = false
     
    }
    
}

// MARK: - Extensions
extension StatisticMatchController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            labelMainTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            labelMainTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            labelMainTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            labelMainTitle.heightAnchor.constraint(equalToConstant: 25),
            
            logoTeamAway.widthAnchor.constraint(equalToConstant: 60),
            logoTeamAway.heightAnchor.constraint(equalToConstant: 60),
            logoTeamHome.widthAnchor.constraint(equalToConstant: 60),
            logoTeamHome.heightAnchor.constraint(equalToConstant: 60),
            
            stackViewFixture.topAnchor.constraint(equalTo: labelMainTitle.bottomAnchor, constant: 15),
            stackViewFixture.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            stackViewFixture.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            stackViewFixture.heightAnchor.constraint(equalToConstant: 90),
            
            statisticMatchTableView.topAnchor.constraint(equalTo: stackViewFixture.bottomAnchor, constant: 15),
            statisticMatchTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            statisticMatchTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            statisticMatchTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        ])
    }
}
