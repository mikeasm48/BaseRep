//
//  TopRatedAssembly.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//
import UIKit

/// Сборка модуля популярных фильмов
final class TopRatedAssembly: ModuleAssemblyProtocol {
    static func build() -> UIViewController {
        let viewController = TopRatedViewController()
        let service = NetworkService(session: SessionFactory.getDefaultSession())
        let interactor = TopRatedInteractor(networkService: service)
        let presenter = TopRatedPresenter()
        let router = TopRatedRouter()
        let dataHolder = DataHolder()

        interactor.presenter = presenter
        interactor.dataModel = DataModel.shared
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        viewController.dataHolder = dataHolder
        router.viewController = viewController

        return viewController
    }
}
