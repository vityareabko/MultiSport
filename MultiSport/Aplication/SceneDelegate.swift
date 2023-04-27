//
//  SceneDelegate.swift
//  MultiSport
//
//  Created by Витя Рябко on 05/03/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let nav = UINavigationController(rootViewController: MainViewController())
        
        window.rootViewController = NotesController()
        
        self.window = window
        self.window?.makeKeyAndVisible()
    }



}

