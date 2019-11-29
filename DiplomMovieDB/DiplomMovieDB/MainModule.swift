//
//  MainModule.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 28.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class MainModule: BuilderProtocol {
    static func build() -> UIViewController {
        let service = NetworkService(session: SessionFactory().createDefaultSession())
        let interactor: InteractorInputProtocol = ListInteractor(networkService: service)
        let presenter = ListPresenter(interactor: interactor)
        interactor.setOutput(output: presenter)
        let movieListViewController = ListView(presenter: presenter)
        presenter.output = movieListViewController
        return movieListViewController
    }
}
