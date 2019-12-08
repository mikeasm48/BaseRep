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
        let service = NetworkService(session: SessionFactory.getDefaultSession())
        let interactor = FavoritesInteractor(networkService: service)
        let presenter = FavoritesPresenter()
        let router = FavoritesRouter()
        let dataHolder = DataHolder()

        interactor.presenter = presenter
        interactor.dataModel = DataModel.shared
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        viewController.dataHolder = dataHolder
        router.viewController = viewController

        _ = UINavigationController.init(rootViewController: viewController)

        return viewController
    }
}
