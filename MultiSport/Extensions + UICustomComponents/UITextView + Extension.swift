//
//  UITextView + Extension.swift
//  MultiSport
//
//  Created by Витя Рябко on 28/04/23.
//

import UIKit

extension UITextView {
    
    convenience init(placeholder: String) {
        self.init()
        self.text = ""
        self.textColor = .systemGray4
        self.font = .gothamBold15()
        self.backgroundColor = .specialBagroubdSubviews
        self.layer.cornerRadius = 7
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textContainerInset = UIEdgeInsets(top: 20, left: 7, bottom: 20, right: 7)
        self.attributedText = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.specialLight,
                                                                                   .font: UIFont.gothamBold15() ?? .systemFont(ofSize: 15)])
        
    }
    
}

