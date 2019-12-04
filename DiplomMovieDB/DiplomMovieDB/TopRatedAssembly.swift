//
//  TopRatedAssembly.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//
import UIKit

final class TopRatedAssembly: AssemblyProtocol {
    static func build() -> UIViewController {
        let viewController = TopRatedViewController()
        //TODO одна сессия на каждый модуль или одна на всех?
        let service = NetworkService(session: SessionFactory().createDefaultSession())
        let interactor = TopRatedInteractor(networkService: service)
        let presenter = TopRatedPresenter()
        let router = TopRatedRouter()

        interactor.presenter = presenter
        interactor.dataModel = DataModel.shared
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController

        return viewController
    }
}
