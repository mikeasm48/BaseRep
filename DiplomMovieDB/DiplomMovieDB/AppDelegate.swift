//
//  AppDelegate.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let listViewController = ListAssembly.build()
        let favoritesViewController = FavoritesAssembly.build()
        window?.rootViewController = initTabBar(root: getRoot(viewController: listViewController),
                                                favorite: favoritesViewController)
        window?.makeKeyAndVisible()
        return true
    }

    private func getRoot(viewController: UIViewController) -> UIViewController {
        guard let navigationController = viewController.navigationController else {
            return viewController
        }
        return navigationController
    }

    private func initTabBar(root: UIViewController, favorite: UIViewController) -> UITabBarController {
        let tabBarController = UITabBarController()

        root.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        favorite.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)

        tabBarController.viewControllers = [root, favorite]

        return tabBarController
    }
}
