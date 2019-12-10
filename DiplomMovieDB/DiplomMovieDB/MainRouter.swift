//
//  MainRouter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

/// Протокол роутера главного модуля
protocol MainRouterProtocol {
}

/// Не используется в текущей реализации, оставлен для единообразия модулей
final class MainRouter: MainRouterProtocol {
    weak var viewController: (MainViewControllerProtocol & UIViewController)?
}
