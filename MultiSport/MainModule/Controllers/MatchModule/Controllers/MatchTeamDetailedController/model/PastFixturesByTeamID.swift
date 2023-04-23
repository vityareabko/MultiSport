//
//  PastFixturesByTeamID.swift
//  MultiSport
//
//  Created by Витя Рябко on 23/04/23.
//

import UIKit

struct PastFixturesByTeamID {
    
    let fixtureId: Int
    let homeTeamName: String
    var logoHomeTeam: UIImage?
    let logoURLHomeTeam: String
    let winHomeTeam: Bool
    let goalsHomeTeam: Int
    
    let awayTeamName: String
    var logoAwayTeam: UIImage?
    let logoURLAwayTeam: String
    let winAwayTeam: Bool
    let goalsAwayTeam: Int
    
    let dateFixture: Date
    let score: String
    
}
