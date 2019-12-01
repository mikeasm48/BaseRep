//
//  MainModule.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 28.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class MainModule: ModuleProtocol {
    var navigationController: UINavigationController?
    private var presenter: PresenterInputProtocol?

    func buildModule() -> ModuleProtocol {
        let service = NetworkService(session: SessionFactory().createDefaultSession())
        let interactor: InteractorInputProtocol = ListInteractor(networkService: service)
        let listPresenter = ListPresenter(interactor: interactor)
        interactor.setOutput(output: listPresenter)
        let movieListViewController = ListView(presenter: listPresenter)
        listPresenter.output = movieListViewController
        self.presenter = listPresenter
        let navigationViewController = UINavigationController.init(rootViewController: movieListViewController)
        navigationController = navigationViewController
        return self
    }

    func getView() -> UIViewController? {
        return navigationController
    }

    func getPresenter() -> PresenterInputProtocol? {
        return presenter
    }

    func getNavigationController() -> UINavigationController? {
        return navigationController
    }
}
