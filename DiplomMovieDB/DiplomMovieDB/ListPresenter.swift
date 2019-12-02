//
//  Presenter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol ListPresenterProtocol {
    func reloadData(data: [ListMovieImageDataModel])
}

class ListPresenter: ListPresenterProtocol {
    weak var viewController: ListViewController?

    func reloadData(data: [ListMovieImageDataModel]) {
            var listModel: [ListMovieModel] = []

            for dataItem in data {
                guard let image = UIImage(data: dataItem.image) else {
                    continue
                }
                let model = ListMovieModel(movie: dataItem.movie, image: image)
                listModel.append(model)
            }
            MovieModel.shared.setMovies(list: listModel)
            viewController?.tableView.reloadData()
    }
}
