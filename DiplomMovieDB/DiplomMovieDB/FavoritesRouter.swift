//
//  FavoritesRouter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol FavoritesRouterProtocol {
    func openDetailsModule(movie: MovieDataModel)
}

final class FavoritesRouter: FavoritesRouterProtocol {
    weak var viewController: (FavoritesViewControllerProtocol & UIViewController)?
    
    func openDetailsModule(movie: MovieDataModel) {
        DataHolder.setMovie(movie: movie)
        let detailsController = DetailsAssembly.build()
        //TODO
        //viewController?.navigationController?.pushViewController(detailsController, animated: true)
    }
}
