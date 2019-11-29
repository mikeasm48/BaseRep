//
//  Presenter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

//protocol ListPresenterInput {
//    func showMovieDetails(movie: MovieDataModel)
//    func showMovieDefaultList()
//    func search(by: String)
//}
//
//protocol ListPresenterOutput {
//    func showMovieDetails(detailMovie: DetailViewModel)
//    func reloadMovieList(movieViewList: [MovieDataModel])
//}

class ListPresenter: PresenterInputProtocol, InteractorOutputProtocol {
    let interactor: InteractorInputProtocol
    var output: PresenterOutputProtocol?

    init (interactor: InteractorInputProtocol) {
        self.interactor = interactor
        self.output = nil
    }

    func show() {
        interactor.loadDataAsync()
    }

    func reloadData(data: [InteractorOutputDataType]) {
            var listModel: [PresenterOutputDataType] = []
            
            for dataItem in data {
                guard let image = UIImage(data: dataItem.imageData) else {
                    continue
                }
                let model = PresenterOutputDataType(movie: dataItem.movie, image: image)
                listModel.append(model)
            }
            output?.didLoadData(data: listModel)
    }

    func search(by: String){
        //TODO
    }
}
