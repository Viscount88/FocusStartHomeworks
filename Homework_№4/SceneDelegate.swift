//
//  SceneDelegate.swift
//  Homework_№4
//
//  Created by Андрей Шамин on 11/4/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: winScene)

        let masterController = MasterViewController()
        let navMasterController = UINavigationController(rootViewController: masterController)

        let detailController = DetailViewController()
        let navigationDetailController = UINavigationController(rootViewController: detailController)

        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [navMasterController, navigationDetailController]
        splitViewController.preferredDisplayMode = .oneBesideSecondary
        splitViewController.delegate = self

        window?.rootViewController = splitViewController
        window?.makeKeyAndVisible()
    }
}

extension SceneDelegate: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
            return true
    }
}
