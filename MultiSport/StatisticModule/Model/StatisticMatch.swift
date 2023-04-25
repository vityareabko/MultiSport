//
//  StatisticMatch.swift
//  MultiSport
//
//  Created by Витя Рябко on 24/04/23.
//

import Foundation

struct StatisticTeam {
    let nameTeam: String
    
    var shotsOnGoal: Int?
    var shotsOffGoal: Int?
    var totalShots: Int?
    var blockedShots: Int?
    var shotsInsideBox: Int?
    var shotsOutsideBox: Int?
    var fouls: Int?
    var cornerKicks: Int?
    var offsides: Int?
    var ballPossession: String?
    var yellowCards: Int?
    var redCards: Int?
    var goalKeeperSaves: Int?
    var totalPasses: Int?
    var passesAcurate: Int?
    var passesPercent: String?
    var expectedGoals: String?
    
    var actionAreas: String?
    
}

struct StatisticTypeValue {
    let type: String // statistic type
    var valueTeamHome: Int?
    var valueTeamAway: Int?
    
    var valueTeamHomeStr: String?
    var valueTeamAwayStr: String?
}


//[StatisticTypeValue]
//[ [vopros, znachHome, znachAway] ] 
