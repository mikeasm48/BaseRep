//
//  ListRouter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

/// Протокол роутера модуля последних поступлений
protocol ListRouterProtocol: ModuleRouterProtocol {
}

/// Роутер последних поступлений
final class ListRouter: ListRouterProtocol {
    weak var viewController: (ListViewControllerProtocol & UIViewController)?

    /// Открывает модуль простомтра деталей фильма
    ///
    /// - Parameter movie: фильм для простора деталей
    func openDetails (movie: MovieDataModel) {
        DataHolder.setMovie(movie: movie)
        let detailsController = DetailsAssembly.build()
        viewController?.navigationController?.pushViewController(detailsController, animated: true)
    }
}
