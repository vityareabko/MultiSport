//
//  FactorController.swift
//  MultiSport
//
//  Created by Витя Рябко on 29/04/23.
//

import UIKit

class FactorController: UIViewController {
    
    // MARK: - UI Components
    private let factorTableView = FactorTableView()
    
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
        self.view.addSubview(factorTableView)
        
        factorTableView.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Extensions
extension FactorController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabelController.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabelController.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleLabelController.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            titleLabelController.heightAnchor.constraint(equalToConstant: 25),
            
            factorTableView.topAnchor.constraint(equalTo: titleLabelController.bottomAnchor, constant: 30),
            factorTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            factorTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            factorTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
