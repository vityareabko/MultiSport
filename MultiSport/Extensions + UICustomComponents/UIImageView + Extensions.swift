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
        self.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        self.contentMode = .scaleAspectFit
        self.tintColor = .systemGray5
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
