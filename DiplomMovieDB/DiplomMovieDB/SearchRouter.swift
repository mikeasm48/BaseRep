//
//  SearchRouter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol SearchRouterProtocol: ModuleRouterProtocol {
}

final class SearchRouter: SearchRouterProtocol {
    weak var viewController: (SearchViewControllerProtocol & UIViewController)?

    func openDetails(movie: MovieDataModel) {
        DataHolder.setMovie(movie: movie)
        let detailsController = DetailsAssembly.build()
        viewController?.navigationController?.pushViewController(detailsController, animated: true)
    }
}
