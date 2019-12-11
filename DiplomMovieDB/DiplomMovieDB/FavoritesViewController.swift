//
//  FavoritesViewController.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit
/// Протокол контроллера модуля сохраненных в избранном фильмов
protocol FavoritesViewControllerProtocol: TableViewControllerProtocol {
}
/// Контроллер модуля сохраненных в избранном фильмов
class FavoritesViewController: AbstractTableViewController, FavoritesViewControllerProtocol {
    var interactor: FavoritesInteractorProtocol?
    var router: FavoritesRouterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Избранное"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         interactor?.loadDataAsync()
    }

    /// Открыввем модуль просмотра деталей
    ///
    /// - Parameter indexPath: строка таблицы в формате делегата
    override func selectRow(indexPath: IndexPath) {
        router?.openDetails(movie: getDataHolder().getMovie(index: indexPath.row))
    }

    /// Получение данных от презентера
    ///
    /// - Parameters:
    ///   - movies: фильмы
    ///   - images: изображения
    override func didLoadData(movies: [MovieDataModel], images: [String: UIImage?]) {
        dataHolder?.resetData()
        dataHolder?.setData(movies: movies, images: images)
        tableView.reloadData()
    }
}
