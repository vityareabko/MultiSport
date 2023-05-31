//
//  UITextField + Extensions.swift
//  MultiSport
//
//  Created by Витя Рябко on 28/04/23.
//

import UIKit

extension UITextField {
    convenience init(placeholder: String, bgColor: UIColor = UIColor.specialBagroubdSubviews) {
        self.init()
        self.text = ""
        self.font = .gothamBold13()
        self.textColor = .systemGray4
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.specialLight])
        self.layer.cornerRadius = 7
        self.backgroundColor = bgColor
        
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 17, height: 0))
        self.leftViewMode = .always
        
        self.autocorrectionType = .default
        self.autocapitalizationType = .sentences
        self.clearButtonMode = .whileEditing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
