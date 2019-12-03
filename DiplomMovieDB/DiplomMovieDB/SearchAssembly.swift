//
//  SearchAssembly.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

final class SearchAssembly: AssemblyProtocol {
    static func build() -> UIViewController {
        let viewController = SearchViewController()
        //TODO одна сессия на каждый модуль или одна на всех?
        let service = NetworkService(session: SessionFactory().createDefaultSession())
        let interactor = SearchInteractor(networkService: service)
        let presenter = SearchPresenter()
        let router = SearchRouter()

        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController

        return viewController
    }
}
