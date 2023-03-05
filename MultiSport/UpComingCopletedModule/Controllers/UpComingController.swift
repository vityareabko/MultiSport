//
//  UpComingController.swift
//  MultiSport
//
//  Created by Витя Рябко on 05/03/23.
//

import UIKit

class UpComingController: UIViewController {
    
    // MARK: - Variables
    
    
    // MARK: - UI Components
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        
        self.view.backgroundColor = .specialMainBaground
        
        
        createCustomNavigationBar()
        navigationController?.navigationBar.barTintColor = .blue

        let burgerButton = createCustomButton(imageName: "burger", selector: #selector(didTapBurger))
        let arrowBack = createCustomButton(imageName: "back", selector: #selector(didTapBack))
//
        navigationItem.rightBarButtonItem = burgerButton
        navigationItem.leftBarButtonItem = arrowBack
        
        
        setConstraints()
    }
    
    // MARK: - Selectors
    
    
    @objc private func didTapBurger() {
        print("didTapBurger")
    }
    
    @objc private func didTapBack() {

        navigationController?.popViewController(animated: true)
    }
    
}

extension UpComingController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
        ])
    }
}


