//
//  DetailsAssembly.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

final class DetailsAssembly: AssemblyProtocol {
    static func build() -> UIViewController {
        let viewController = DetailsViewController()
        //TODO одна сессия на каждый модуль или одна на всех?
        let service = NetworkService(session: SessionFactory.getDefaultSession())
        let interactor = DetailsInteractor(networkService: service)
        let presenter = DetailsPresenter()
        let router = DetailsRouter()

        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController

        return viewController
    }
}
