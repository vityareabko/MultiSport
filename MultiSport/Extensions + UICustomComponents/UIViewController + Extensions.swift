//
//  UIViewController + Extensions.swift
//  MultiSport
//
//  Created by Витя Рябко on 05/03/23.
//

import UIKit

extension UIViewController {

    // MARK: - setupSecondViewController
    func setupSecondViewController(viewController: UIViewController, view: UIView) {
        self.addChild(viewController)
        self.view.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 20),
            viewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        ])
    }
    
    // MARK: - Remove Last Child Controller on parent ViewController
    func removeChildController(childController: UIViewController) {
        // при нажатия на ячейку колекцию я должен вызвать эту функцию
        childController.removeFromParent()
        childController.view.removeFromSuperview()
    }
}
