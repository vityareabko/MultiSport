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
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
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
