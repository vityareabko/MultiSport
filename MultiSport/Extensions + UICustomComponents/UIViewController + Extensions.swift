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
            viewController.view.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 15),
            viewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        ])
    }
    
    // MARK: - Remove Last Child Controller on parent ViewController
    func removeChildController(childController: UIViewController) {
        childController.removeFromParent()
        childController.view.removeFromSuperview()
    }
    
    // MARK: - setNavigation Bar
    func setNavigationBar() {
        let backAtHome: UIButton = {
            let button = UIButton()
            let image = UIImage(systemName: "chevron.backward")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            button.setImage(image, for: .normal)
            button.setTitle("Back", for: .normal)
            button.tintColor = .white
            button.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
            return button
        }()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backAtHome)
    }
    
    // MARK: - Selectors
    @objc private func dismissController() {
        navigationController?.popViewController(animated: true)
    }
}
