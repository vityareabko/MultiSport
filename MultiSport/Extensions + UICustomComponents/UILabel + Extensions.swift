//
//  UILabel + Extensions.swift
//  MultiSport
//
//  Created by Витя Рябко on 04/04/23.
//

import UIKit

extension UILabel {
    convenience init(text: String, textColor: UIColor, font: UIFont?) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.font = font
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
