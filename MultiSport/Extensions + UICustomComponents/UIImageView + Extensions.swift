//
//  UIImageView + Extensions.swift
//  MultiSport
//
//  Created by Витя Рябко on 04/04/23.
//

import UIKit

extension UIImageView {
    convenience init(imageName: String) {
        self.init()
        self.image = UIImage(named: imageName)
        self.contentMode = .scaleAspectFit
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
