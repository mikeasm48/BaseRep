//
//  MainAssembly.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

final class MainAssembly: ModuleAssemblyProtocol {
    static func build() -> UIViewController {
        let mainViewController = MainViewController()
        let recentListViewController = ListAssembly.build()
        let topRatedViewController = TopRatedAssembly.build()
        mainViewController.topRatedViewController = topRatedViewController
        mainViewController.recentListViewController = recentListViewController
        
         _ = UINavigationController.init(rootViewController: mainViewController)
        return mainViewController
    }
}
