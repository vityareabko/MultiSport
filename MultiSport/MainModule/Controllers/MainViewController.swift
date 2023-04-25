//
//  ViewController.swift
//  MultiSport
//
//  Created by Витя Рябко on 05/03/23.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Controllers
//    private var childControllerMatchTable: MatchController?  //
    private let sportTypeCollectionView = SportTypeCollectionView() // это колекция
    
    private let childControllerMainTable = MaintTableViewController() // таблица с категореями
    
    private var childTableController: MatchesTableController? // контролер с таблицей и секции матчи
    
    private var childCollectionController: MatchCollectionController? // контроллер с колецией команд

    private var childControllerMatchesTeam: MatchesTeamController? // контролеп который идет после нажатия кнопки в контролере с колецией команд
    
    private var prevsVC = [UIViewController]()
    
    // MARK: - UI Components
    private lazy var buttonComming = UIButton(text: "UPCOMING", textColor: .systemGray5, bgColor: .specialBagroubdSubviews, font: .gothamBold15())
    private lazy var buttonCompleted = UIButton(text: "COMPLETED", textColor: .systemGray5, bgColor: .specialBagroubdSubviews, font: .gothamBold15())

    
    private lazy var logIn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" LOG IN", for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = .gothamBold11()
        button.tintColor = .white
        let image = UIImage(named: "login")?.withTintColor(UIColor.specialOrangeColor, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(didTapSignUP), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var backAtHome: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "chevron.backward")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.setTitle("Home", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didtapHome), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    // MARK: - UI Components
    private lazy var segmentControl : UISegmentedControl = {
        let sc = UISegmentedControl(items: ["UPCOMING", "COMPLETED"])
        sc.selectedSegmentIndex = 0
        sc.backgroundColor = .specialBagroubdSubviews
        sc.selectedSegmentTintColor = .specialOrangeColor
        sc.setTitleTextAttributes([.font: UIFont.gothamBold15()!, .foregroundColor: UIColor.systemGray5], for: .normal)
        sc.setTitleTextAttributes([.foregroundColor: UIColor.specialMainBaground], for: .selected)
        sc.addTarget(self, action: #selector(didTappedSegment), for: .valueChanged)
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.isHidden = true
        return sc
    }()
    
    
    private var stackViewButtons = UIStackView()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setNavbar()
        setConstraints()
        setupSecondViewController(viewController: childControllerMainTable, view: segmentControl)
        sportTypeCollectionView.selecdItemCollectionDelegate = self
        
//        prevsVC.append(childControllerMainTable)
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        self.view.backgroundColor = .specialMainBaground
        
        setStackView()
        
        buttonComming.addTarget(self, action: #selector(didtapButton), for: .touchUpInside)
        buttonCompleted.addTarget(self, action: #selector(didtapButton), for: .touchUpInside)
        buttonComming.tag = 0
        buttonCompleted.tag = 1
        
        self.view.addSubview(sportTypeCollectionView)
        self.view.addSubview(stackViewButtons)
        self.view.addSubview(segmentControl)
        sportTypeCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    // MARK: - Settings navbar
    private func setNavbar() {
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: signUp), UIBarButtonItem(customView: logIn)]
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backAtHome)
    }
    
    
    // MARK: - setStackView
    private func setStackView() {
        stackViewButtons = UIStackView(arrangedSubviews: [buttonComming, buttonCompleted])
        stackViewButtons.axis = .horizontal
        stackViewButtons.spacing = 7
        stackViewButtons.distribution = .fillEqually
        stackViewButtons.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Functionns
    private func segmentControlCotntollers(selectItem: Int) {
        switch selectItem{
        case 0:
            childTableController = MatchesTableController()
            setupSecondViewController(viewController: childTableController!, view: segmentControl)
        case 1:
            childCollectionController = MatchCollectionController()
            childCollectionController!.setDelegate(delagateVC: self)
            setupSecondViewController(viewController: childCollectionController!, view: segmentControl)
        default:
            print("errorc")
        }
    }
    
//    private func appendViewControllerToArray(vc: UIViewController) {
//        if !self.prevsVC.contains(vc) {
//            self.prevsVC.append(vc)
//        }
//    }
    
    // MARK: - Selectors
    @objc private func didTapLogin(){
        let vc = LoginController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapSignUP(){
        let vc = LoginController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didtapHome(sender: UIButton) {
        if let lastChildController = children.last {
            removeChildController(childController: lastChildController)
        }
        sportTypeCollectionView.unselectedAllCells()
        setupSecondViewController(viewController: childControllerMainTable, view: segmentControl)
        stackViewButtons.isHidden = false
        segmentControl.isHidden = true
        sender.isHidden = true
    }
    
    @objc private func didtapButton(sender: UIButton) {
        stackViewButtons.isHidden = true
        segmentControl.isHidden = false
        backAtHome.isHidden = false
        
        sportTypeCollectionView.selectItem(at: [0,0], animated: false, scrollPosition: .right)
        
        if let lastChildController = children.last {
            if !self.prevsVC.contains(lastChildController) {
                self.prevsVC.append(lastChildController)
            }
            print(self.prevsVC)
            removeChildController(childController: lastChildController)
        }
        
        segmentControlCotntollers(selectItem: sender.tag)
        segmentControl.selectedSegmentIndex = sender.tag
    }
    
    // MARK: - Selectors
    @objc private func didTappedSegment(sender: UISegmentedControl) {
        if let lastChildController = children.last {
            if !self.prevsVC.contains(lastChildController) {
                self.prevsVC.append(lastChildController)
            }
            print(self.prevsVC)
            removeChildController(childController: lastChildController)
        }
        
        segmentControlCotntollers(selectItem: sender.selectedSegmentIndex)
    }
    
    
}

// MARK: - SelecdItemCollectionProtocol
extension MainViewController: SelecdItemCollectionProtocol {
    func changeViewController() {
        // TODO: - нужно сделать когда находимся уже в 3 контролере к примеру в MatchesTeamController то уже нужно возвращаться к CollectionController или к TableController в зависимости какой был предыдущий
        backAtHome.isHidden = false
        if let lastChildController = children.last {
            removeChildController(childController: lastChildController)
        }
        childTableController = MatchesTableController()
        setupSecondViewController(viewController: childTableController!, view: segmentControl)
        
        segmentControl.isHidden = false
        segmentControl.selectedSegmentIndex = 0
        stackViewButtons.isHidden = true
    }
}

// MARK: - TeamMatchDetailedProtocol
extension MainViewController: TeamMatchDetailedProtocol {
    func selectTeamMatchesDetailed(model: TeamModel) {
        if let lastChildController = children.last {
            removeChildController(childController: lastChildController)
        }
        childControllerMatchesTeam = MatchesTeamController()

        guard let vc = childControllerMatchesTeam else { return }
        vc.setData(model: model)
        
        setupSecondViewController(viewController: vc, view: segmentControl)
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
            
            segmentControl.topAnchor.constraint(equalTo: sportTypeCollectionView.bottomAnchor, constant: 20),
            segmentControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            segmentControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            segmentControl.heightAnchor.constraint(equalToConstant: 50),
            
            buttonComming.heightAnchor.constraint(equalToConstant: 50),
            buttonCompleted.heightAnchor.constraint(equalToConstant: 50),
            
            stackViewButtons.topAnchor.constraint(equalTo: sportTypeCollectionView.bottomAnchor, constant: 20),
            stackViewButtons.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            stackViewButtons.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            stackViewButtons.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}


