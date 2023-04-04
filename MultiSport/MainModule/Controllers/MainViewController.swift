//
//  ViewController.swift
//  MultiSport
//
//  Created by Витя Рябко on 05/03/23.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - UI Components
    
    private let sportTypeCollectionView = SportTypeCollectionView()
    private let mainTableView = MainTableView()
    
    private let upcomingMatchesButton = UIButton(text: "UPCOMING", textColor: .systemGray5, bgColor: .specialLight, font: .gothamBold15())
    private let completedMatchesButton = UIButton(text: "COMPLETED", textColor: .systemGray5, bgColor: .specialLight, font: .gothamBold15())
    
    private var stackViewMainButtons = UIStackView()
    
    private lazy var logIn: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didtap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setNavbar()
        setConstraints()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        self.view.backgroundColor = .specialMainBaground
        
        setStackView()
        
        self.view.addSubview(sportTypeCollectionView)
        self.view.addSubview(mainTableView)
        self.view.addSubview(stackViewMainButtons)

        sportTypeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Settings StackView
    private func setStackView() {
        stackViewMainButtons = UIStackView(arrangedSubviews: [upcomingMatchesButton, completedMatchesButton])
        stackViewMainButtons.axis = .horizontal
        stackViewMainButtons.spacing = 10
        stackViewMainButtons.distribution = .fillEqually
        stackViewMainButtons.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Settings navbar
    private func setNavbar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logIn)
    }
    
    
    // MARK: - Functions
    
    
    
    
    // MARK: - Selectors
    @objc private func didtap(){
        let vc = LoginController()
        self.navigationController?.pushViewController(vc, animated: true)
    }   
}

// MARK: - Extensions
extension MainViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            sportTypeCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 110),
            sportTypeCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            sportTypeCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            sportTypeCollectionView.heightAnchor.constraint(equalToConstant: 55),
            
            stackViewMainButtons.topAnchor.constraint(equalTo: sportTypeCollectionView.bottomAnchor, constant: 25),
            stackViewMainButtons.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            stackViewMainButtons.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            stackViewMainButtons.heightAnchor.constraint(equalToConstant: 50),
            
            mainTableView.topAnchor.constraint(equalTo: stackViewMainButtons.bottomAnchor, constant: 25),
            mainTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}


