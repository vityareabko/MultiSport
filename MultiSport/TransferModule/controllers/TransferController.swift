//
//  TransferController.swift
//  MultiSport
//
//  Created by Витя Рябко on 31/05/23.
//

import UIKit

class TransferController: UIViewController {
    
    // MARK: - UI Components
    private let transferTableView = TransferTableView()
    private let titleLabelController = UILabel(text: "TRANSFERS", textColor: .specialOrangeColor, font: .gothamBold22())
    
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
        self.view.addSubview(transferTableView)
        
        transferTableView.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Constraints
extension TransferController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabelController.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabelController.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleLabelController.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            titleLabelController.heightAnchor.constraint(equalToConstant: 25),
            
            transferTableView.topAnchor.constraint(equalTo: titleLabelController.bottomAnchor, constant: 30),
            transferTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            transferTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            transferTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
