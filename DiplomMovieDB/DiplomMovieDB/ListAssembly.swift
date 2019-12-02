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
        let service = NetworkService(session: SessionFactory().createDefaultSession())
        let interactor = ListInteractor(networkService: service)
        let viewController = ListViewController()
        let presenter = ListPresenter()
        let router = ListRouter()

        viewController.interactor = interactor
        viewController.router = router
        presenter.viewController = viewController
        router.viewController = viewController
        interactor.presenter = presenter
        _ = UINavigationController.init(rootViewController: viewController)

        return viewController
    }
}
