//
//  ListRouter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol ListRouterProtocol {
    func openDetailsModule(movie: MovieDataModel)
}

final class ListRouter: ListRouterProtocol {
    weak var viewController: (ListViewControllerProtocol & UIViewController)?

    func openDetailsModule(movie: MovieDataModel) {
        MovieDataHolder.setMovie(movie: movie)
        let detailsController = DetailsAssembly.build()
        viewController?.navigationController?.pushViewController(detailsController, animated: true)
    }
}
