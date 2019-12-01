//
//  DetailsModule.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 30.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class DetailsModule: ModuleProtocol {

    var view: UIViewController?
    var presenter: DetailsPresenter?

    func buildModule() -> ModuleProtocol {
        let service = NetworkService(session: SessionFactory().createDefaultSession())
        let interactor = DetailsInteractor(networkService: service)

        interactor.setOutput(output: createPresenter(interactor: interactor))

        view = DetailsView(nibName: nil, bundle: nil)
        return self
    }
    func getView() -> UIViewController? {
       return view
    }

    func getPresenter() -> PresenterInputProtocol? {
        return presenter
    }

    private func createPresenter(interactor: DetailsInteractor) -> DetailsPresenter {
        let newPresenter = DetailsPresenter(interactor: interactor)
        presenter = newPresenter
        return newPresenter
    }

    func getNavigationController() -> UINavigationController? {
        return nil
    }
}
