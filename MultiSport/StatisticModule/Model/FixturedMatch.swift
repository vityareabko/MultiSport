//
//  FixturedMatch.swift
//  MultiSport
//
//  Created by Витя Рябко on 23/04/23.
//

import UIKit

struct FixturedMatch {
    
    let homeTeamName: String
    let homeTeamURLLogo: String
    var homeLogo: UIImage?
    
    let awayTeamName: String
    let awayTeamURLLogo: String
    var awayLogo: UIImage?
    
    let dateFixture: Date
    let scoreFixture: String
}
