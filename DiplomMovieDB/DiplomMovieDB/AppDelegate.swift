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

    // MARK: - Private methods

    private func getRoot(viewController: UIViewController) -> UIViewController {
        guard let navigationController = viewController.navigationController else {
            return viewController
        }
        return navigationController
    }

    private func initTabBar(root: UIViewController,
                            favorite: UIViewController,
                            search: UIViewController) -> UITabBarController {
        let tabBarController = UITabBarController()
        let filmImage = UIImage(named: "Film")
        let starImage = UIImage(named: "Star")
        let searchImage = UIImage(named: "Search")
        root.tabBarItem = UITabBarItem(title: "Фильмы", image: filmImage, selectedImage: filmImage)
        favorite.tabBarItem = UITabBarItem(title: "Избранное", image: starImage, selectedImage: starImage)
        search.tabBarItem = UITabBarItem(title: "Поиск", image: searchImage, selectedImage: searchImage)
        tabBarController.viewControllers = [root, favorite, search]
        return tabBarController
    }
}
