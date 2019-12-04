//
//  TopRatedInteractor.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

protocol TopRatedInteractorProtocol {
    func loadDataAsync()
}

class TopRatedInteractor: Interactor, TopRatedInteractorProtocol {
    var presenter: TopRatedPresenterProtocol?
    var dataModel: MovieModel?

    func loadDataAsync() {
        let url = API.discoverPath(sortBy: "popularity.desc",
                                   page: getNextFetchedPage(fetchData: dataModel?.getTopRatedFetchData()))
        loadMovieList(url: url) { [weak self] (fetchData, models) in
            self?.loadMoviePosterImages(with: models) { [weak self] results in
                self?.presenter?.reloadData(fetchData: fetchData, data: results)
            }
        }
    }
}
