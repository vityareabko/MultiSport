//
//  UIView + Extension.swift
//  MultiSport
//
//  Created by Витя Рябко on 29/04/23.
//

import UIKit

extension UIView {
    func shake(horizontal: CGFloat = 5, verticatly: CGFloat = 0){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - horizontal, y: self.center.y - verticatly))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + horizontal, y: self.center.y + verticatly))
        
        self.layer.add(animation, forKey: "position")
    }
}

