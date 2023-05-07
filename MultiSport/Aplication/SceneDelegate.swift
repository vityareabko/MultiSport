//
//  SceneDelegate.swift
//  MultiSport
//
//  Created by Витя Рябко on 05/03/23.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    private func goToControll(with viewController: UIViewController) {
        let nav = UINavigationController(rootViewController: viewController)
        nav.modalPresentationStyle = .fullScreen
        self.window?.rootViewController = nav
    }
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.setupWindow(with: scene)
        self.checkAuthentication()
    }
    
    func checkAuthentication() {
        if Auth.auth().currentUser == nil {
            let vc = SignInController()
            goToControll(with: vc)
        } else {
            let vc = MainViewController()
            goToControll(with: vc)
        }
    }
    
}

