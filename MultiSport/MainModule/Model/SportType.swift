//
//  SportType.swift
//  MultiSport
//
//  Created by Витя Рябко on 04/04/23.
//

import Foundation
import UIKit

enum SportType: String, CaseIterable {
    case football
    case hockey
    case basketball
    case voleyball
    
    var image: UIImage? {
        UIImage(named: self.rawValue)
    }
}
