//
//  MainTablesTypeItem.swift
//  MultiSport
//
//  Created by Витя Рябко on 04/04/23.
//

import Foundation
import UIKit

enum MainTablesTypeItem: String, CaseIterable {
    case statistics
    case calendar
    case notes
    case factor
    case favorites
    case league
    case team
    case transfer
    case victories
    case betSimulation = "Bet Simulation"
    case myBets = "My Bets"
    case shop
    
    var image: UIImage? {
        switch self {
        case .betSimulation: return UIImage(named: "betSimulation")
        case .myBets: return UIImage(named: "myBets")
        default: return UIImage(named: self.rawValue)
        }
        
    }
    
    var title: String {
        self.rawValue.uppercased()
    }
    
}
