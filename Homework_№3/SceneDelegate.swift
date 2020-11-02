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

        let tabBarController = TabBarController()

        let firstController = FirstViewController()
        let firstControllerBarItem = UITabBarItem(title: "Первый экран", image: UIImage(systemName: "01.circle"), selectedImage: UIImage(systemName: "01.circle.fill"))
        firstController.tabBarItem = firstControllerBarItem

        let secondController = SecondViewController()
        let secondControllerBarItem = UITabBarItem(title: "Второй экран", image: UIImage(systemName: "02.circle"), selectedImage: UIImage(systemName: "02.circle.fill"))
        secondController.tabBarItem = secondControllerBarItem

        let thirdController = ThirdViewController()
        let thirdControllerBarItem = UITabBarItem(title: "Третий экран", image: UIImage(systemName: "03.circle"), selectedImage: UIImage(systemName: "03.circle.fill"))
        thirdController.tabBarItem = thirdControllerBarItem

        tabBarController.viewControllers = [firstController, secondController,thirdController]
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

