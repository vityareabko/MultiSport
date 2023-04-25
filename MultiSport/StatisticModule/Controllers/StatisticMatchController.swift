//
//  StatisticMatchController.swift
//  MultiSport
//
//  Created by Витя Рябко on 19/04/23.
//

import UIKit


//V3 - Fixtures by fixture id

// TODO: - демонстрация №9

class StatisticMatchController: UIViewController {
    
    // id матча
    private var idFixture: Int = -1
    private var arrayTypeValue = [StatisticTypeValue]()
    
    // MARK: - UI Components
    private let statisticMatchTableView = StatisticMatchTableView()
    
    private let labelMainTitle = UILabel(text: "STATISTICS", textColor: .specialOrangeColor, font: .gothamBold22())
    
    private let labelTeamNameHome = UILabel(text: "Milan", textColor: .systemGray5, font: .gothamBold15())
    private let labelTeamNameAway = UILabel(text: "Real Madrid", textColor: .systemGray5, font: .gothamBold15())
    private let labelScore = UILabel(text: "1 : 0", textColor: .specialOrangeColor, font: .gothamBold24())
    private let labelDate = UILabel(text: "Dec 19", textColor: .specialLight, font: .gothamBold13())
    
    private let logoTeamHome = UIImageView(imageName: "team1")
    private let logoTeamAway = UIImageView(imageName: "team2")
    
    
    private var stackViewFixture = UIStackView()
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
        
        // делаем запросы и обновляем данные
        fetchStatistickMatch()
    }
    
    private func fetchStatistickMatch() {
        let request = NetworkManager.shared.request(with: .fixturesByFixturesID(idFixture: self.idFixture))
        guard let r = request else { return }
        requestStatistickMatch(with: r)
    }
    
    private func requestStatistickMatch(with url: URL) {
        NetworkDataFetch.shared.fetchStatisticMatchByIdFixtures(urlRequest: url) { result in
            
            switch result {
            case .success(let data):
                guard let dataResponse = data.response else { return }
                self.processResponse(dataResponse)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    private func processResponse(_ response: [StatisticMatchResponse]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
   
        for item in response {

            guard case let .statisticMatchTeam(homeTeam) = item.teams.home,
                  case let .statisticMatchTeam(awayTeam) = item.teams.away else {
                return
            }
            
            guard case let .integer(scoreHomeTeam) = item.goals.home,
                  case let .integer(scoreAwayTeam) = item.goals.away else {
                return
            }
            
            guard let date = dateFormatter.date(from: item.fixture.date) else {
                return
            }
            
            dateFormatter.dateFormat = "MMM d"
            
            self.labelTeamNameHome.text = homeTeam.name
            self.labelTeamNameAway.text = awayTeam.name
            self.labelScore.text = "\(scoreHomeTeam) : \(scoreAwayTeam)"
            self.labelDate.text = dateFormatter.string(from: date)
            let awayTeamURLlogo = awayTeam.logo
            let homeTeamURLlogo = homeTeam.logo
            
            
            
            downloadAndUpdateTeamLogo(with: [homeTeamURLlogo, awayTeamURLlogo])
        
            // извлекаем даные из декодированой структуры в нашу структуру
            let teamHomeStats = processTeamStatistics(team: homeTeam, stats: item.statistics)
            let teamAwayStats = processTeamStatistics(team: awayTeam, stats: item.statistics)

            // пытаемся извлечь данные
            if var homeStats = teamHomeStats, var awayStats = teamAwayStats {
                calculateAction(team1: &homeStats, team2: &awayStats)
                
                
                // cокращаем вместо 54.432432423% будет 54.4%
                let intValue = String(homeStats.actionAreas!.filter { $0.isNumber })
                let firstThreeDigits = Double(String(intValue.prefix(3))) ?? 0
                let actionAreas = String(firstThreeDigits / 10) + "%"

                let intValue1 = String(awayStats.actionAreas!.filter { $0.isNumber })
                let firstThreeDigits1 = Double(String(intValue1.prefix(3))) ?? 0
                let actionAreas1 = String(firstThreeDigits1 / 10) + "%"
                
                // добовляес вычесляемое свойство статистика на основе уже существущих данных
                // и добовляем в начале
                arrayTypeValue.insert(StatisticTypeValue(type: "Action Areas",
                                                         valueTeamHomeStr: actionAreas,
                                                         valueTeamAwayStr: actionAreas1),
                                      at: 0)
                
                
                // добовления в масив даные статистики команд, и конечно же свойство type
                for i in 0..<arrayTypeValue.count {
                    switch arrayTypeValue[i].type {
                    case "Shots on Goal":
                        arrayTypeValue[i].valueTeamHome = homeStats.shotsOnGoal
                        arrayTypeValue[i].valueTeamAway = awayStats.shotsOnGoal
                    case "Shots off Goal":
                        arrayTypeValue[i].valueTeamHome = homeStats.shotsOffGoal
                        arrayTypeValue[i].valueTeamAway = awayStats.shotsOffGoal
                    case "Total Shots":
                        arrayTypeValue[i].valueTeamHome = homeStats.totalShots
                        arrayTypeValue[i].valueTeamAway = awayStats.totalShots
                    case "Blocked Shots":
                        arrayTypeValue[i].valueTeamHome = homeStats.blockedShots
                        arrayTypeValue[i].valueTeamAway = awayStats.blockedShots
                    case "Shots insidebox":
                        arrayTypeValue[i].valueTeamHome = homeStats.shotsInsideBox
                        arrayTypeValue[i].valueTeamAway = awayStats.shotsInsideBox
                    case "Shots outsidebox":
                        arrayTypeValue[i].valueTeamHome = homeStats.shotsOutsideBox
                        arrayTypeValue[i].valueTeamAway = awayStats.shotsOutsideBox
                    case "Fouls":
                        arrayTypeValue[i].valueTeamHome = homeStats.fouls
                        arrayTypeValue[i].valueTeamAway = awayStats.fouls
                    case "Corner Kicks":
                        arrayTypeValue[i].valueTeamHome = homeStats.cornerKicks
                        arrayTypeValue[i].valueTeamAway = awayStats.cornerKicks
                    case "Offsides":
                        arrayTypeValue[i].valueTeamHome = homeStats.offsides
                        arrayTypeValue[i].valueTeamAway = awayStats.offsides
                    case "Yellow Cards":
                        arrayTypeValue[i].valueTeamHome = homeStats.yellowCards
                        arrayTypeValue[i].valueTeamAway = awayStats.yellowCards
                    case "Red Cards":
                        arrayTypeValue[i].valueTeamHome = homeStats.redCards
                        arrayTypeValue[i].valueTeamAway = awayStats.redCards
                    case "Goalkeeper Saves":
                        arrayTypeValue[i].valueTeamHome = homeStats.goalKeeperSaves
                        arrayTypeValue[i].valueTeamAway = awayStats.goalKeeperSaves
                    case "Total passes":
                        arrayTypeValue[i].valueTeamHome = homeStats.totalPasses
                        arrayTypeValue[i].valueTeamAway = awayStats.totalPasses
                    case "Passes accurate":
                        arrayTypeValue[i].valueTeamHome = homeStats.passesAcurate
                        arrayTypeValue[i].valueTeamAway = awayStats.passesAcurate
                    case "Ball Possession":
                        arrayTypeValue[i].valueTeamHomeStr = homeStats.ballPossession
                        arrayTypeValue[i].valueTeamAwayStr = awayStats.ballPossession
                    case "Passes %":
                        arrayTypeValue[i].valueTeamHomeStr = homeStats.passesPercent
                        arrayTypeValue[i].valueTeamAwayStr = awayStats.passesPercent
                    case "expected_goals":
                        arrayTypeValue[i].valueTeamHomeStr = homeStats.expectedGoals
                        arrayTypeValue[i].valueTeamAwayStr = awayStats.expectedGoals
                    default:
                        break
                    }
                    
                }

                self.statisticMatchTableView.setData(arrayTypeValue)
                self.statisticMatchTableView.reloadData()
                
            }
        }
    }
    
  
    // Вычеслям новое свойство на основе уже существующих,
    // вычеслям тут так как нам нужны данные обеих команд а в экземпляре структуры входит только одна команда
    private func calculateAction(team1: inout StatisticTeam, team2: inout StatisticTeam) {
        let metricsWeights = [
            "ballPossession": 0.5,
            "shotsOnGoal": 0.2,
            "totalPasses": 0.2,
            "goalKeeperSaves": 0.1
        ]
        
        var team1TotalWeightedScore = 0.0
        var team2TotalWeightedScore = 0.0
        
        for (metric, weight) in metricsWeights {
            var team1Value = 0
            var team2Value = 0
            
            switch metric {
            case "ballPossession":
                team1Value = Int(team1.ballPossession?.replacingOccurrences(of: "%", with: "") ?? "0") ?? 0
                team2Value = Int(team2.ballPossession?.replacingOccurrences(of: "%", with: "") ?? "0") ?? 0
            case "shotsOnGoal":
                team1Value = team1.shotsOnGoal ?? 0
                team2Value = team2.shotsOnGoal ?? 0
            case "totalPasses":
                team1Value = team1.totalPasses ?? 0
                team2Value = team2.totalPasses ?? 0
            case "goalKeeperSaves":
                team1Value = team1.goalKeeperSaves ?? 0
                team2Value = team2.goalKeeperSaves ?? 0
            default:
                break
            }
            
            let totalValue = Double(team1Value + team2Value)
            if totalValue > 0 {
                team1TotalWeightedScore += (Double(team1Value) / totalValue) * weight
                team2TotalWeightedScore += (Double(team2Value) / totalValue) * weight
            }
        }
        
        let totalWeightedScore = team1TotalWeightedScore + team2TotalWeightedScore
        let team1ActionPercent = (team1TotalWeightedScore / totalWeightedScore) * 100
        let team2ActionPercent = (team2TotalWeightedScore / totalWeightedScore) * 100
        
        team1.actionAreas = "\(team1ActionPercent)%"
        team2.actionAreas = "\(team2ActionPercent)%"
    }
        

    // загрузка логотипов команд
    private func downloadAndUpdateTeamLogo(with urlStringImage: [String]) {
        Task {
            let logoHomeTeam = await GetImageRequest.shared.test(with: urlStringImage[0])
            let logoAwayTeam = await GetImageRequest.shared.test(with: urlStringImage[1])
            
            DispatchQueue.main.async {
                self.logoTeamHome.image = logoHomeTeam
                self.logoTeamAway.image = logoAwayTeam
            }
        }
        
    }
    
    // извлекаем даные из экземляпра декодераСтруктуры и создаем заполняем новую структуру
    func processTeamStatistics(team: StatisticMatchTeam, stats: [StatisticMatchResponseStatistic]) -> StatisticTeam? {
        // ищем статистику для данной команды
        guard let teamStats = stats.first(where: { $0.team.id == team.id }) else {
            print("Statistics not found for team: \(team.name)")
            return nil
        }
        
        var statisticTeam = StatisticTeam(nameTeam: team.name)

        // Process each statistic for the given team
        for stat in teamStats.statistics {
            
            // для того чтобы только один раз заполнил type statistic
            // type - извлекаем только один раз так как функцию вызывается два раза для двух команд то вот сделали проверку
            if arrayTypeValue.count <= teamStats.statistics.count {
                let stv = StatisticTypeValue(type: stat.type)
                arrayTypeValue.append(stv)
            }
            
            // если у нас приходит value в типе Int
            if let intValue = getValue(statistic: stat) as? Int {
//                print("\(team.name) \(stat.type): \(intValue)")
                
                switch stat.type {
                case "Shots on Goal":
                    statisticTeam.shotsOnGoal = intValue
                case "Shots off Goal":
                    statisticTeam.shotsOffGoal = intValue
                case "Total Shots":
                    statisticTeam.totalShots = intValue
                case "Blocked Shots":
                    statisticTeam.blockedShots = intValue
                case "Shots insidebox":
                    statisticTeam.shotsInsideBox = intValue
                case "Shots outsidebox":
                    statisticTeam.shotsOutsideBox = intValue
                case "Fouls":
                    statisticTeam.fouls = intValue
                case "Corner Kicks":
                    statisticTeam.cornerKicks = intValue
                case "Offsides":
                    statisticTeam.offsides = intValue
                case "Yellow Cards":
                    statisticTeam.yellowCards = intValue
                case "Red Cards":
                    statisticTeam.redCards = intValue
                case "Goalkeeper Saves":
                    statisticTeam.goalKeeperSaves = intValue
                case "Total passes":
                    statisticTeam.totalPasses = intValue
                case "Passes accurate":
                    statisticTeam.passesAcurate = intValue
                default:
                    break
                }
            }
            
            // если у нас приходит value в типе String
            if let stringValue = getValue(statistic: stat) as? String {
//                print("\(team.name) \(stat.type): \(stringValue)")
                switch stat.type {
                case "Ball Possession":
                    statisticTeam.ballPossession = stringValue
                case "Passes %":
                    statisticTeam.passesPercent = stringValue
                case "expected_goals":
                    statisticTeam.expectedGoals = stringValue
                default:
                    break
                }
            }
                
        }

        return statisticTeam
    }
    
    // cдесь мы возвращаем тип value
    func getValue(statistic: StatisticMatchStatisticStatistic) -> Any {
        switch statistic.value {
        case .integer(let value):
            return value
        case .string(let value):
            return value
        default:
            return 0
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .specialMainBaground
        
        // из extesion + UIViewController
        setNavigationBar()
 
        labelMainTitle.textAlignment = .center
        labelTeamNameAway.textAlignment = .center
        labelTeamNameHome.textAlignment = .center
        labelDate.textAlignment = .center
        labelScore.textAlignment = .center
        
        labelTeamNameAway.numberOfLines = 2
        labelTeamNameHome.numberOfLines = 2
        
        
        setStackView()
        
        self.view.addSubview(labelMainTitle)
        self.view.addSubview(stackViewFixture)
        
        self.view.addSubview(statisticMatchTableView)
        statisticMatchTableView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setStackView() {
        let stackViewTeamHome = UIStackView(arrangedSubviews: [logoTeamHome, labelTeamNameHome])
        stackViewTeamHome.axis = .vertical
        stackViewTeamHome.spacing = 5
        stackViewTeamHome.distribution = .equalSpacing
        
        let stackViewTeamAway = UIStackView(arrangedSubviews: [logoTeamAway, labelTeamNameAway])
        stackViewTeamAway.axis = .vertical
        stackViewTeamAway.spacing = 5
        stackViewTeamAway.distribution = .equalSpacing
        
        let stackViewScore = UIStackView(arrangedSubviews: [labelDate, labelScore])
        stackViewScore.axis = .vertical
        stackViewScore.spacing = 0
        stackViewScore.distribution = .fillEqually
       
    
        stackViewFixture = UIStackView(arrangedSubviews: [stackViewTeamHome, stackViewScore, stackViewTeamAway])
        stackViewFixture.axis = .horizontal
        stackViewFixture.spacing = 10
        stackViewFixture.distribution = .equalSpacing
        
 
        stackViewFixture.translatesAutoresizingMaskIntoConstraints = false
     
    }
    
    public func setIdFixture(idFixture: Int) {
        self.idFixture = idFixture
    }
    
}

// MARK: - Extensions
extension StatisticMatchController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            labelMainTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            labelMainTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            labelMainTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            labelMainTitle.heightAnchor.constraint(equalToConstant: 25),
            
            logoTeamAway.widthAnchor.constraint(equalToConstant: 60),
            logoTeamAway.heightAnchor.constraint(equalToConstant: 60),
            logoTeamHome.widthAnchor.constraint(equalToConstant: 60),
            logoTeamHome.heightAnchor.constraint(equalToConstant: 60),
            
            stackViewFixture.topAnchor.constraint(equalTo: labelMainTitle.bottomAnchor, constant: 15),
            stackViewFixture.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            stackViewFixture.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            stackViewFixture.heightAnchor.constraint(equalToConstant: 90),
            
            statisticMatchTableView.topAnchor.constraint(equalTo: stackViewFixture.bottomAnchor, constant: 15),
            statisticMatchTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            statisticMatchTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            statisticMatchTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        ])
    }
}
