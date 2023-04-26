//
//  MaintTableViewController.swift
//  MultiSport
//
//  Created by Витя Рябко on 09/04/23.
//

import UIKit

class MaintTableViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let mainTableView = MainTableView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .clear
        
        self.view.addSubview(mainTableView)
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func setDelegate(vc: UIViewController) {
        mainTableView.pushToControllDelegate = vc as? PushToControllerProtocol
    }
}

// MARK: - Contstraints
extension MaintTableViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
