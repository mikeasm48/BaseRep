//
//  MainRouter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol MainRouterProtocol {
}

final class MainRouter: MainRouterProtocol {
    weak var viewController: (MainViewControllerProtocol & UIViewController)?
}
