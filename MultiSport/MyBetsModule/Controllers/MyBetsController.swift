//
//  MyBetsController.swift
//  MultiSport
//
//  Created by Витя Рябко on 31/05/23.
//

import UIKit

class MyBetsController: UIViewController {
    
    // MARK: - UI Components
    private let myBetsTableView = MyBetsTableView()
    private let titleLabelController = UILabel(text: "MY BETS", textColor: .specialOrangeColor, font: .gothamBold22())
    
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
        self.view.addSubview(myBetsTableView)
        
        myBetsTableView.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Constraints
extension MyBetsController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabelController.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabelController.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleLabelController.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            titleLabelController.heightAnchor.constraint(equalToConstant: 25),
            
            myBetsTableView.topAnchor.constraint(equalTo: titleLabelController.bottomAnchor, constant: 30),
            myBetsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            myBetsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            myBetsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
