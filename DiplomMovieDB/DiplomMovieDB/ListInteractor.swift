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

class ListInteractor: Interactor, ListInteractorProtocol{
    
    var presenter: ListPresenterProtocol?

    func loadDataAsync() {
         let url = API.discoverPath(sortBy: "popularity.desc",
                                    page: DataModel.shared.getNextFetchPage(list: ListType.lastRecent))

        loadMovieList(list: ListType.lastRecent, url: url) { [weak self] (models) in
            self?.loadImages(with: models.map{model in model.backdropPath})
        }
    }

    private func loadImages(with names: [String]){
        self.loadMovieImages(with: names) { [weak self] in
            self?.presenter?.reloadData()
        }
    }
}
