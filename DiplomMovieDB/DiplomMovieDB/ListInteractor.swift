//
//  Interactor.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import  Foundation

protocol ListInteractorProtocol {
    func loadDataAsync()
}

class ListInteractor: Interactor, ListInteractorProtocol {
    var presenter: ListPresenterProtocol?
    var dataModel: MovieModel?

    func loadDataAsync() {
         let url = API.discoverPath(sortBy: "popularity.desc",
                                    page: getNextFetchedPage(fetchData: dataModel?.getMoviesFetchData()))

        loadMovieList(url: url) { [weak self] (fetchData, models) in
            self?.loadMovieBackdropImages(with: models) { [weak self] results in
                self?.presenter?.reloadData(fetchData: fetchData, data: results)
            }
        }
    }
}
