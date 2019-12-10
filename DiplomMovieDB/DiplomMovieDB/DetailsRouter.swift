//
//  DetailsRouter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//
import UIKit

/// Протокол роутера модуля отображения деталей фильма
protocol DetailsRouterProtocol {
}
/// Роутер модуля отображения деталей фильма
/// не используется в текущей реализации, нужен для однообразия модулей
final class DetailsRouter: DetailsRouterProtocol {
    weak var viewController: (DetailsViewControllerProtocol & UIViewController)?
}
