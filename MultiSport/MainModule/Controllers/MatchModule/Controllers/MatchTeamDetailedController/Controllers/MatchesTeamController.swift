//
//  MatchesTeamController.swift
//  MultiSport
//
//  Created by Витя Рябко on 19/04/23.
//

import UIKit



class MatchesTeamController: UIViewController {
    
    // MARK: - Variables
    
    // id главной команды
    private var idTeam: Int = -1
    private var arrayFixtures = [PastFixturesByTeamID]()
    
    // MARK: - UI Components
    private let matchesTeamTable = MatchesTeamTable()
    
    private let logoMainTeam = UIImageView(imageName: "team1")
    private let labelMainTeam = UILabel(text: "Main Team", textColor: .systemGray5, font: .gothamBold24())
    
    /* это для будущих динамичных констрейнтов(при скролле будем менять multiplier) */
    private var logoMainTeamWidthConstraint: NSLayoutConstraint?
    private var logoMainTeamHeightConstraint: NSLayoutConstraint?
    


    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setDelegate()
        setConstraints()
        
        // запросы и обновления таблицы
        fetchPastTeamEvents()
    }
    
    
    // обработка запросв в асинхроном режиме
    private func fetchPastTeamEvents() {
        let request = NetworkManager.shared.request(with: .fixturesByTeamId(teamID: self.idTeam))
        guard let r = request else { return }
        responsePastTeamEvents(with: r)
    }
    
    private func responsePastTeamEvents(with url: URL) {
        NetworkDataFetch.shared.fetchHistoryTeamMatches(urlRequest: url) { [weak self] result in
            switch result {
            case .success(let data):
                guard let self = self else { return }
                guard let dataResponse = data.response else { return }
                
                processResponse(dataResponse)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
 
    private func processResponse(_ response: [HistoryTeamMatchesResponse]) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        for item in response {
                
            guard case let .historyTeamMatchesAwayClass(homeTeam) = item.teams.home,
                  case let .historyTeamMatchesAwayClass(awayTeam) = item.teams.away else {
                return
            }
            
            guard case let .integer(scorHomeTeam) = item.goals.home,
                  case let .integer(scoreAwayTeam) = item.goals.away else {
                return
            }
            
            guard let winHomeTeam = homeTeam.winner,
                  let winAwayTeam = awayTeam.winner else {
                return
            }
            
            let fixtureId = item.fixture.id
            let nameTeamHome = homeTeam.name
            let logoURLTeamHome = homeTeam.logo
            let goalsHomeTeam = scorHomeTeam
            let nameTeamAway = awayTeam.name
            let logoURLTeamAway = awayTeam.logo
            let goalsAwayTeam = scoreAwayTeam
            
            guard let dateFixture = dateFormatter.date(from: item.fixture.date) else { return }
            
            let scoreFixture = "\(scorHomeTeam) : \(scoreAwayTeam)"

            let fixture = PastFixturesByTeamID(fixtureId: fixtureId,
                                                homeTeamName: nameTeamHome,
                                                logoURLHomeTeam: logoURLTeamHome,
                                                winHomeTeam: winHomeTeam,
                                                goalsHomeTeam: goalsHomeTeam,
                                                awayTeamName: nameTeamAway,
                                                logoURLAwayTeam: logoURLTeamAway,
                                                winAwayTeam: winAwayTeam,
                                                goalsAwayTeam: goalsAwayTeam,
                                                dateFixture: dateFixture,
                                                score: scoreFixture)
            
            downloadAndUpdateTeamLogo(for: fixture)
        }
    }
    
    private func downloadAndUpdateTeamLogo(for fixture: PastFixturesByTeamID) {
        Task {
            
            let homeTeamLogo = await GetImageRequest.shared.test(with: fixture.logoURLHomeTeam)
            let awayTeamLogo = await GetImageRequest.shared.test(with: fixture.logoURLAwayTeam)
            
            DispatchQueue.main.async {
                var updatedFixture = fixture
                updatedFixture.logoHomeTeam = homeTeamLogo
                updatedFixture.logoAwayTeam = awayTeamLogo
                
                self.arrayFixtures.append(updatedFixture)
                
                self.matchesTeamTable.setData(model: self.arrayFixtures)
                self.matchesTeamTable.reloadData()
            }
        }
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .clear
        
        labelMainTeam.textAlignment = .center
        
        self.view.addSubview(logoMainTeam)
        self.view.addSubview(labelMainTeam)
        self.view.addSubview(matchesTeamTable)
        matchesTeamTable.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDelegate() {
        matchesTeamTable.statisticMatchDelegate = self
        matchesTeamTable.changeConstrainDelegate = self
    }
    
    public func setData(model: TeamModel) {
        self.idTeam = model.id
        self.logoMainTeam.image = model.teamLogo
        self.labelMainTeam.text = model.teamName.uppercased()
    }
}

// MARK: - StatisticMatchProtocol
extension MatchesTeamController : StatisticMatchProtocol {
    func presentStatistic(idFixture: Int) {
        let vc = StatisticMatchController()
        vc.setIdFixture(idFixture: idFixture)
        print(idFixture)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extensions
extension MatchesTeamController {
    private func setConstraints() {
        /* это для того чтобы потом небыло конфликта когда меняем коефициент этих констрейнтов */
        logoMainTeamWidthConstraint = logoMainTeam.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: matchesTeamTable.logoMainTeamInitialWidth)
        logoMainTeamHeightConstraint = logoMainTeam.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: matchesTeamTable.logoMainTeamInitialWidth)
        logoMainTeamWidthConstraint?.isActive = true
        logoMainTeamHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            logoMainTeam.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 25),
            logoMainTeam.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            labelMainTeam.topAnchor.constraint(equalTo: logoMainTeam.bottomAnchor, constant: 15),
            labelMainTeam.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            labelMainTeam.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            labelMainTeam.heightAnchor.constraint(equalToConstant: 25),
            
            matchesTeamTable.topAnchor.constraint(equalTo: labelMainTeam.bottomAnchor, constant: 15),
            matchesTeamTable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            matchesTeamTable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            matchesTeamTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}


extension MatchesTeamController: ChangeConstrainProtocol {
    func changeContstraints(width: CGFloat, height: CGFloat) {
        if let widthConstraint = logoMainTeamWidthConstraint, let heightConstraint = logoMainTeamHeightConstraint {
            NSLayoutConstraint.deactivate([widthConstraint, heightConstraint])
        }
        
        if Int(height) == Int(matchesTeamTable.logoMainTeamMinimumWidth) {
            labelMainTeam.font = .gothamBold15()
        } else {
            labelMainTeam.font = .gothamBold24()
        }
        
        logoMainTeamWidthConstraint = logoMainTeam.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: width)
        logoMainTeamHeightConstraint = logoMainTeam.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: height)
        logoMainTeamWidthConstraint?.isActive = true
        logoMainTeamHeightConstraint?.isActive = true
        
        self.view.setNeedsUpdateConstraints()
        
    }
}


