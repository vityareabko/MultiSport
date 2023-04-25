//
//  TeamModel.swift
//  MultiSport
//
//  Created by Витя Рябко on 09/04/23.
//


import UIKit

struct TeamModel : Equatable {
//    let teamNameHome: String
//    var teamLogoHome: UIImage?
//    let teamLogoHomeURL: String
//
//    let teamNameAway: String
//    var teamLogoAway: UIImage?
//    let teamLogoAwayURL: String
    let id: Int
    let teamName: String
    var teamLogo: UIImage?
    let teamURLLogo: String
    
    static func ==(lhs: TeamModel, rhs: TeamModel) -> Bool {
        return lhs.teamName == rhs.teamName
    }
}

