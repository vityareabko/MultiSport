//
//  BetConttoller.swift
//  MultiSport
//
//  Created by Витя Рябко on 31/05/23.
//

import UIKit

class BetConttoller: UIViewController {
    
    // MARK: - UI Components
    private let titleLabelController = UILabel(text: "BET", textColor: .specialOrangeColor, font: .gothamBold22())
    private let betView = BetView()
    
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
        self.view.addSubview(betView)
        
        betView.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Constraints
extension BetConttoller {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabelController.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabelController.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleLabelController.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            titleLabelController.heightAnchor.constraint(equalToConstant: 25),
            
            betView.topAnchor.constraint(equalTo: titleLabelController.bottomAnchor, constant: 35),
            betView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            betView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            betView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
