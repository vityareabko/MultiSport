//
//  SportDescription.swift
//  MultiSport
//
//  Created by Витя Рябко on 06/04/23.
//

import UIKit

enum SportDescriptionTitle: String, CaseIterable {
    case premium = "Premium League"
    case laLigha = "LA League"
    case champion = "Champion League"
}

struct SportDescription {
    let title: SportDescriptionTitle
    
    let teamNameFirst: String
    var teamIconeFirst: UIImage? {
        UIImage(named: "mosk")
    }
    
    let teamNameSecond: String
    var teamIconeSecond: UIImage? {
        UIImage(named: "ekatburg")
    }
    
    let matchDate: Date
    var matchIcon: UIImage? {
        UIImage(named: "clock")
    }
    
    
    static func createData() -> [SportDescription] {
        let a1matchDate: Date = Date()

        let a1 = SportDescription(title: .premium,
                                  teamNameFirst: "Mosc city",
                                  teamNameSecond: "Ekatburg",
                                  matchDate: Date(timeIntervalSince1970: a1matchDate.timeIntervalSince1970 + 5000.0))
        
        let a2 = SportDescription(title: .champion,
                                  teamNameFirst: "Barcelona",
                                  teamNameSecond: "Dinamo Kyev",
                                  matchDate: Date(timeIntervalSince1970: a1matchDate.timeIntervalSince1970 + 10000.0))
        
        return [a1, a2]
    }
}

struct SportDescriptionSection {
    let title: SportDescriptionTitle
    let items: [SportDescription]
}
