//
//  VictoryController.swift
//  MultiSport
//
//  Created by Витя Рябко on 31/05/23.
//

import UIKit

class VictoryController: UIViewController {
    
    // MARK: - UI Components
    private let titleLabelController = UILabel(text: "VICTORYS", textColor: .specialOrangeColor, font: .gothamBold22())
    private let vitctoryTableView = VitctoryTableView()
    
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
        self.view.addSubview(vitctoryTableView)
        
        vitctoryTableView.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Constraints
extension VictoryController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabelController.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabelController.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleLabelController.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            titleLabelController.heightAnchor.constraint(equalToConstant: 25),
            
            vitctoryTableView.topAnchor.constraint(equalTo: titleLabelController.bottomAnchor, constant: 35),
            vitctoryTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            vitctoryTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            vitctoryTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
