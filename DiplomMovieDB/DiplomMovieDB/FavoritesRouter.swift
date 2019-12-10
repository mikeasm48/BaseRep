//
//  FavoritesRouter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

/// Протокол роутера модуля сохраненных в избранном фильмов
protocol FavoritesRouterProtocol: ModuleRouterProtocol {
}
/// Роутер модуля сохраненных в избранном фильмов
final class FavoritesRouter: FavoritesRouterProtocol {
    weak var viewController: (FavoritesViewControllerProtocol & UIViewController)?

    /// Открывает детали фильма
    ///
    /// - Parameter movie: данные фильма
    func openDetails(movie: MovieDataModel) {
        DataHolder.setMovie(movie: movie)
        let detailsController = DetailsAssembly.build()
        viewController?.navigationController?.pushViewController(detailsController, animated: true)
    }
}
