//
//  TopRatedRouter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol TopRatedRouterProtocol {
    func openDetailsModule(movie: MovieDataModel)
}

final class TopRatedRouter: TopRatedRouterProtocol {
    weak var viewController: (TopRatedViewControllerProtocol & UIViewController)?
    
    func openDetailsModule(movie: MovieDataModel) {
        MovieDataHolder.setMovie(movie: movie)
        let detailsController = DetailsAssembly.build()
        viewController?.navigationController?.pushViewController(detailsController, animated: true)
    }
}
