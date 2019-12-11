//
//  TopRatedRouter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

/// Протокол роутера популярных фильмов
protocol TopRatedRouterProtocol: ModuleRouterProtocol {
}
/// Роутер популярных фильмов
final class TopRatedRouter: TopRatedRouterProtocol {
    weak var viewController: (TopRatedViewControllerProtocol & UIViewController)?

    /// Открывает модуль просмотра деталей
    ///
    /// - Parameter movie: данные фильма для просмотра деталей
    func openDetails(movie: MovieDataModel) {
        DataHolder.setMovie(movie: movie)
        let detailsController = DetailsAssembly.build()
        viewController?.navigationController?.pushViewController(detailsController, animated: true)
    }
}
