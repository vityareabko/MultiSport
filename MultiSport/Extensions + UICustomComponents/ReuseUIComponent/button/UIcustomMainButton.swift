//
//  UIcustomMainButton.swift
//  MultiSport
//
//  Created by Витя Рябко on 05/03/23.
//

import UIKit

class UIcustomMainButton: UIButton {
    
    init(text: String, font: UIFont?, bgColor: UIColor){
        super.init(frame: .zero)
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = font
        self.backgroundColor = bgColor
        self.layer.cornerRadius = 7
        self.tintColor = (bgColor == .specialBagroubdSubviews) ? .white : .specialOrangeColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
