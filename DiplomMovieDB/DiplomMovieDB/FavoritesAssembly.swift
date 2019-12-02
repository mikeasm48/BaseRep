//
//  FavoritesAssembly.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

final class FavoritesAssembly: AssemblyProtocol {
    static func build() -> UIViewController {
        let viewController = FavoritesViewController()
        //TODO одна сессия на каждый модуль или одна на всех?
        let service = NetworkService(session: SessionFactory().createDefaultSession())
        let interactor = FavoritesInteractor(networkService: service)
        let presenter = FavoritesPresenter()
        let router = FavoritesRouter()

        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController

        return viewController
    }
}
