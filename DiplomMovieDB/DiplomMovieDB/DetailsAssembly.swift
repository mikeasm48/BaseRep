//
//  DetailsAssembly.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

/// Сборка модуля деталей фильма
final class DetailsAssembly: ModuleAssemblyProtocol {
    static func build() -> UIViewController {
        let viewController = DetailsViewController()
        let service = NetworkService(session: SessionFactory.getDefaultSession())
        let coreDataStack = CoreDataStack()
        let interactor = DetailsInteractor(networkService: service, coreDataStack: coreDataStack)
        let presenter = DetailsPresenter()
        let router = DetailsRouter()
        let detailsViewFactory = DetailsViewFactory(viewController: viewController)

        interactor.presenter = presenter
        interactor.dataModel = DataModel.shared
        presenter.viewController = viewController
        presenter.detailsViewFactory = detailsViewFactory
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController

        return viewController
    }
}
