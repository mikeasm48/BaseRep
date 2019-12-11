//
//  MainAssembly.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

/// Сборка главного модуля
final class MainAssembly: ModuleAssemblyProtocol {
    /// Собираем главный модуль из двух:
    ///- топ фильмы вверху (scroll view)
    ///- последние поступления  внизу (table view)
    /// - Returns:  контроллер модуля
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
