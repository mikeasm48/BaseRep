//
//  FavoritesViewController.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol FavoritesViewControllerProtocol: TableViewControllerProtocol {
}

class FavoritesViewController: AbstractTableViewController, FavoritesViewControllerProtocol {
    var interactor: FavoritesInteractorProtocol?
    var router: FavoritesRouterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Избранное"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         interactor?.loadSavedMovies()
    }

    override func getCaption() -> String {
        return "Сохраненные"
    }
    
    override func selectRow(indexPath: IndexPath) {
        router?.openDetailsModule(movie: getDataHolder().getMovie(index: indexPath.row))
    }

    override func didLoadData(movies: [MovieDataModel], images: [String : UIImage?]) {
        dataHolder?.resetData()
        dataHolder?.setData(movies: movies, images: images)
        tableView.reloadData()
    }
}
