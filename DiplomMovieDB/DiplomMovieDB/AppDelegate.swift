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

        let mainViewController = MainAssembly.build()
        let favoritesViewController = FavoritesAssembly.build()
        let searchViewController = SearchAssembly.build()
        window?.rootViewController = initTabBar(root: getRoot(viewController: mainViewController),
                                                favorite: getRoot(viewController: favoritesViewController),
                                                search: getRoot(viewController: searchViewController))
        window?.makeKeyAndVisible()
        return true
    }

    private func getRoot(viewController: UIViewController) -> UIViewController {
        guard let navigationController = viewController.navigationController else {
            return viewController
        }
        return navigationController
    }

    private func initTabBar(root: UIViewController, favorite: UIViewController, search: UIViewController) -> UITabBarController {
        let tabBarController = UITabBarController()
        let selectedColor   = UIColor(red: 246.0/255.0, green: 155.0/255.0, blue: 13.0/255.0, alpha: 1.0)

        root.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 1)
        root.tabBarItem.badgeColor = selectedColor
        favorite.tabBarItem.
        search.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 3)

        tabBarController.viewControllers = [root, favorite, search]

        return tabBarController
    }
}
