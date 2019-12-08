//
//  FavoritesRouter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol FavoritesRouterProtocol: ModuleRouterProtocol {
}

final class FavoritesRouter: FavoritesRouterProtocol {
    weak var viewController: (FavoritesViewControllerProtocol & UIViewController)?
    
    func openDetails(movie: MovieDataModel) {
        DataHolder.setMovie(movie: movie)
        let detailsController = DetailsAssembly.build()
        viewController?.navigationController?.pushViewController(detailsController, animated: true)
    }
}
