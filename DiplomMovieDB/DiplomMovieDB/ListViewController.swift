//
//  ViewController.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol ListViewControllerProtocol: TableViewControllerProtocol {
}

class ListViewController: AbstractTableViewController, ListViewControllerProtocol {
    var interactor: ListInteractorProtocol?
    var router: ListRouterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func getCaption() -> String {
        return "Последние поступления"
    }

    override func loadData() {
        interactor?.loadDataAsync()
    }

    override func fetchData() {
        loadData()
    }

    override func selectRow(indexPath: IndexPath) {
        router?.openDetailsModule(movie: getDataHolder().getMovie(index: indexPath.row))
    }

    override func didLoadData(movies: [MovieDataModel], images: [String: UIImage?]) {
        dataHolder?.setData(movies: movies, images: images)
        tableView.reloadData()
    }
}
