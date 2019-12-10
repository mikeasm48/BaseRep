//
//  SearchAssembly.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

/// Сборка модуля поиска фильмов
final class SearchAssembly: ModuleAssemblyProtocol {
    static func build() -> UIViewController {
        let viewController = SearchViewController()
        let service = NetworkService(session: SessionFactory.getDefaultSession())
        let interactor = SearchInteractor(networkService: service)
        let presenter = SearchPresenter()
        let router = SearchRouter()
        let dataHolder = DataHolder()

        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        viewController.dataHolder = dataHolder
        router.viewController = viewController

        _ = UINavigationController.init(rootViewController: viewController)

        return viewController
    }
}
