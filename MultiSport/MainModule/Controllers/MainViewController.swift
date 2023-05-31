//
//  ViewController.swift
//  MultiSport
//
//  Created by Витя Рябко on 05/03/23.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Controllers
    private let sportTypeCollectionView = SportTypeCollectionView() // это колекция
    
    private let childControllerMainTable = MaintTableViewController() // таблица с категореями
    
    private var childTableController: MatchesTableController? // контролер с таблицей и секции матчи
    
    private var childCollectionController: MatchCollectionController? // контроллер с колецией команд

    private var childControllerMatchesTeam: MatchesTeamController? // контролеп который идет после нажатия кнопки в контролере с колецией команд
    
    // MARK: - UI Components
    private lazy var buttonComming = UIButton(text: "UPCOMING", textColor: .systemGray5, bgColor: .specialBagroubdSubviews, font: .gothamBold15())
    private lazy var buttonCompleted = UIButton(text: "COMPLETED", textColor: .systemGray5, bgColor: .specialBagroubdSubviews, font: .gothamBold15())

    
    private lazy var logOutButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "login")?.withTintColor(UIColor.specialOrangeColor, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)

        button.addTarget(self, action: #selector(didTappedLogout), for: .touchUpInside)
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
        childControllerMainTable.setDelegate(vc: self)
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        self.view.backgroundColor = .specialMainBaground
        
        setStackView()
        
        // это у нас кнопки который при нажатия на них скрываются и передают таг в segmentControll
        // и вместо кнопок уже показывается segmentControll - так по дизайну нужно
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
        if let currentUser  = AuthService.shared.getCurentUser() {
            AuthService.shared.getUserData(for: currentUser.uid) { [weak self] data, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                self?.title = data["username"] as? String
            }
        }
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backAtHome)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logOutButton)
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
    
    
    // MARK: - Selectors
    @objc private func didTappedLogout() {
        AuthService.shared.signOut { error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
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
    
    // этот селектор работает только когда я нахожусь в MatchesTeamController потом я меняю на другой селектор
    @objc private func didPrevController() {
        if let lastChildController = children.last {
            removeChildController(childController: lastChildController)
        }
        
        backAtHome.removeTarget(self, action: #selector(didPrevController), for: .touchUpInside)
        backAtHome.addTarget(self, action: #selector(didtapHome), for: .touchUpInside)
        
        childCollectionController = MatchCollectionController()
        setupSecondViewController(viewController: childCollectionController!, view: segmentControl)
    }
    
    @objc private func didtapButton(sender: UIButton) {
        stackViewButtons.isHidden = true
        segmentControl.isHidden = false
        backAtHome.isHidden = false
        
        sportTypeCollectionView.selectItem(at: [0,0], animated: false, scrollPosition: .right)
        
        if let lastChildController = children.last {
            removeChildController(childController: lastChildController)
        }
        
        segmentControlCotntollers(selectItem: sender.tag)
        // в зависимости от нажатой кнопки меняю selectedSegmentIndex
        segmentControl.selectedSegmentIndex = sender.tag
    }
    
    // MARK: - Selectors
    @objc private func didTappedSegment(sender: UISegmentedControl) {
        if let lastChildController = children.last {
            removeChildController(childController: lastChildController)
        }
        segmentControlCotntollers(selectItem: sender.selectedSegmentIndex)
    }
}

// MARK: - SelecdItemCollectionProtocol
extension MainViewController: SelecdItemCollectionProtocol {
    func changeViewController() {
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
        
        // это для того чтобы вернуться к предыдущему контроллеру а именно в MatchCollectionController
        // так как он всегда будет предыдущим относительно этого контроллера так как он вызывается из этого контроллера
        backAtHome.removeTarget(self, action: #selector(didtapHome), for: .touchUpInside)
        backAtHome.addTarget(self, action: #selector(didPrevController), for: .touchUpInside)
        
        childControllerMatchesTeam = MatchesTeamController()
        guard let vc = childControllerMatchesTeam else { return }
        vc.setData(model: model)
        
        setupSecondViewController(viewController: vc, view: segmentControl)
    }
}

// MARK: - PushToControllerProtocol
extension MainViewController: PushToControllerProtocol {
    func pushToControll(categories: MainTablesTypeItem) {
        switch categories {
        case .calendar:
            // TODO: - когда пушим то взникает какой-то API - что-то там ....
            navigationController?.pushViewController(CalendarController(), animated: true)
        case .notes:
            navigationController?.pushViewController(NotesController(), animated: true)
        case .factor:
            navigationController?.pushViewController(FactorController(), animated: true)
        case .favorites:
            navigationController?.pushViewController(FavoriteController(), animated: true)
        case .league:
            navigationController?.pushViewController(LeagueController(), animated: true)
        case .team:
            navigationController?.pushViewController(TeamContoller(), animated: true)
        case .transfer:
            navigationController?.pushViewController(TransferController(), animated: true)
        case .victories:
            navigationController?.pushViewController(VictoryController(), animated: true)
        case .betSimulation:
            navigationController?.pushViewController(BetConttoller(), animated: true)
        case .myBets:
            navigationController?.pushViewController(MyBetsController(), animated: true)
        }
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


