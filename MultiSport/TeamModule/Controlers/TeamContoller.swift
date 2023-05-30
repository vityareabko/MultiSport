//
//  TeamContoller.swift
//  MultiSport
//
//  Created by Витя Рябко on 30/05/23.
//

import UIKit

class TeamContoller: UIViewController {
    
    // MARK: - UI Components
    private let teamTableView = TeamTableView()
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
        self.view.addSubview(teamTableView)
        
        teamTableView.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Constraints
extension TeamContoller {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabelController.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabelController.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleLabelController.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            titleLabelController.heightAnchor.constraint(equalToConstant: 25),
            
            teamTableView.topAnchor.constraint(equalTo: titleLabelController.bottomAnchor, constant: 30),
            teamTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            teamTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            teamTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
