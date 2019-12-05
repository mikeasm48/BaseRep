//
//  ListAssembly.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

final class ListAssembly: AssemblyProtocol {
    static func build() -> UIViewController {
        let service = NetworkService(session: SessionFactory.getDefaultSession())
        let interactor = ListInteractor(networkService: service)
        let presenter = ListPresenter()
        let router = ListRouter()
        let viewController = ListViewController()
        let dataHolder = MovieDataHolder()

        viewController.interactor = interactor
        viewController.router = router
        viewController.dataHolder = dataHolder
        presenter.viewController = viewController
        router.viewController = viewController
        interactor.presenter = presenter
        interactor.dataModel = DataModel.shared

        return viewController
    }
}
