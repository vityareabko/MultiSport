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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .clear
        
        self.view.addSubview(matchCollectionView)
        matchCollectionView.translatesAutoresizingMaskIntoConstraints = false
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
