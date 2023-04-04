//
//  UIButton + Extensions.swift
//  MultiSport
//
//  Created by Витя Рябко on 04/04/23.
//

import UIKit

extension UIButton {
    convenience init(text: String, textColor: UIColor, bgColor: UIColor, font: UIFont?){
        self.init(type: .system)
        self.setTitle(text, for: .normal)
        self.titleLabel?.textColor = textColor
        self.tintColor = textColor
        self.titleLabel?.font = font
        self.titleLabel?.text = self.titleLabel?.text?.uppercased()
        self.backgroundColor = bgColor
        self.layer.cornerRadius = 7
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
