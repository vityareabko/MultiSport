//
//  LeagueController.swift
//  MultiSport
//
//  Created by Витя Рябко on 30/05/23.
//

import UIKit

class LeagueController: UIViewController {
    
    // MARK: - UI Components
    private let leagueTableView = LeagueTableView()
    private let titleLabelController = UILabel(text: "Factor", textColor: .specialOrangeColor, font: .gothamBold22())

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setNavigationBar()
        setConstraints()
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .specialMainBaground
        
        self.view.addSubview(titleLabelController)
        self.view.addSubview(leagueTableView)
        
        leagueTableView.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Constraints
extension LeagueController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabelController.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabelController.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleLabelController.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            titleLabelController.heightAnchor.constraint(equalToConstant: 25),
            
            leagueTableView.topAnchor.constraint(equalTo: titleLabelController.bottomAnchor, constant: 30),
            leagueTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            leagueTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            leagueTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
