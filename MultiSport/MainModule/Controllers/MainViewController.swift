//
//  ViewController.swift
//  MultiSport
//
//  Created by Витя Рябко on 05/03/23.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Controllers
    private let childControllerMainTable = MaintTableViewController()
    private var childControllerMatchTable: MatchController?

    
    private let sportTypeCollectionView = SportTypeCollectionView()
    
    // MARK: - UI Components
    private lazy var logIn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" LOG IN", for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = .gothamBold11()
        button.tintColor = .white
        let image = UIImage(named: "login")?.withTintColor(UIColor.specialOrangeColor, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didtap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var signUp: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" SIGN UP", for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = .gothamBold11()
        button.tintColor = .white
        let image = UIImage(named: "signup")?.withTintColor(UIColor.specialOrangeColor, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didtap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var backAtHome: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "chevron.backward")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.setTitle("Back", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didtapHome), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setNavbar()
        setConstraints()
        setupSecondViewController(viewController: childControllerMainTable, view: sportTypeCollectionView)
        sportTypeCollectionView.selecdItemCollectionDelegate = self
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        self.view.backgroundColor = .specialMainBaground
        self.view.addSubview(sportTypeCollectionView)
        sportTypeCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    // MARK: - Settings navbar
    private func setNavbar() {
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: signUp), UIBarButtonItem(customView: logIn)]
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backAtHome)
    }
    
    
    // MARK: - Selectors
    @objc private func didtap(){
        let vc = LoginController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didtapHome(sender: UIButton) {
        if let lastChildController = children.last {
            removeChildController(childController: lastChildController)
        }
        sportTypeCollectionView.unselectedAllCells()
        setupSecondViewController(viewController: childControllerMainTable, view: sportTypeCollectionView)
        sender.isHidden = true
    }
}

// MARK: - SelecdItemCollectionProtocol
extension MainViewController: SelecdItemCollectionProtocol {
    func changeViewController() {
        backAtHome.isHidden = false
        if let lastChildController = children.last {
            removeChildController(childController: lastChildController)
        }
        childControllerMatchTable = MatchController()
        setupSecondViewController(viewController: childControllerMatchTable!, view: sportTypeCollectionView)
    }
}

// MARK: - Contstraints
extension MainViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            sportTypeCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 110),
            sportTypeCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            sportTypeCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            sportTypeCollectionView.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
}


