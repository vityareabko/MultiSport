//
//  MatchController.swift
//  MultiSport
//
//  Created by Витя Рябко on 06/04/23.
//

import UIKit

class MatchController: UIViewController {
    
    // MARK: - UI Components
    
    private let sportTypeCollectionView = SportTypeCollectionView()
    private let matchesTableView = MatchesTableView()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .specialMainBaground

        self.view.addSubview(sportTypeCollectionView)
        self.view.addSubview(matchesTableView)
        matchesTableView.translatesAutoresizingMaskIntoConstraints = false
        sportTypeCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

extension MatchController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            sportTypeCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 110),
            sportTypeCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            sportTypeCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            sportTypeCollectionView.heightAnchor.constraint(equalToConstant: 55),
            
            matchesTableView.topAnchor.constraint(equalTo: sportTypeCollectionView.bottomAnchor, constant: 20),
            matchesTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            matchesTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            matchesTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}


