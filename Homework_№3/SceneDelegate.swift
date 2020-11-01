//
//  SceneDelegate.swift
//  Homework_№3
//
//  Created by Андрей Шамин on 10/30/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: winScene)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
    }
}

