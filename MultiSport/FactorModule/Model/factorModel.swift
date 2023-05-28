//
//  factorModel.swift
//  MultiSport
//
//  Created by Витя Рябко on 26/05/23.
//

import UIKit

struct FactorModel {
    let teamHome: String
    let teamAway: String
    var logoTeamHome: UIImage?
    var logoTeamAway: UIImage?
    
    let kofHome: Double
    let kofAway: Double
    let kofNobody: Double
    
    static func getSomeObjects() -> [FactorModel] {
        var a = FactorModel(teamHome: "Milan",
                           teamAway: "Inter",
                            kofHome: 2.5,
                            kofAway: 3.0,
                            kofNobody: 1.6)
        
        var b = FactorModel(teamHome: "Real Madrid",
                           teamAway: "Barcelona",
                            kofHome: 1.5,
                            kofAway: 3.0,
                            kofNobody: 1.6)
        
        var c = FactorModel(teamHome: "Dynamo Kiev",
                           teamAway: "PSG",
                            kofHome: 2.6,
                            kofAway: 3.0,
                            kofNobody: 1.3)
        
        a.logoTeamHome = UIImage(named: "team1")
        a.logoTeamAway = UIImage(named: "team2")
        b.logoTeamHome = UIImage(named: "team3")
        b.logoTeamAway = UIImage(named: "team1")
        c.logoTeamHome = UIImage(named: "team5")
        c.logoTeamAway = UIImage(named: "team6")
        
        return [a,b,c]
    }
}

struct SectionFactorModel {
    let leagueSection: String
    let logoLeague: UIImage?
    var sectionItems: [FactorModel]
    var expandable: Bool = false
    
    static func getSomeObjects() -> [SectionFactorModel] {
        let items: [FactorModel] = FactorModel.getSomeObjects()
        
        let a = SectionFactorModel(leagueSection: "GOLDEN BOOKMAKER", logoLeague: UIImage(named: "factor1"), sectionItems: items, expandable: true)
        let b = SectionFactorModel(leagueSection: "BET ROYAL", logoLeague: UIImage(named: "factor2"), sectionItems: items)
        let c = SectionFactorModel(leagueSection: "BOOKMAKER CLUB", logoLeague: UIImage(named: "factor3"), sectionItems: items)
        
        return [a,b,c]
    }
}

