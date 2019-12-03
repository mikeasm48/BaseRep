//
//  TopRatedPresenter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//
import UIKit

protocol TopRatedPresenterProtocol {
    func reloadData(data: [ListMovieImageDataModel])
}

class TopRatedPresenter: TopRatedPresenterProtocol {
    var viewController: TopRatedViewController?

    func reloadData(data: [ListMovieImageDataModel]){
        var listModel: [ListMovieModel] = []
        
        for dataItem in data {
            guard let image = UIImage(data: dataItem.image) else {
                continue
            }
            let model = ListMovieModel(movie: dataItem.movie, image: image)
            listModel.append(model)
        }
        
        MovieModel.shared.setTopRated(list: listModel)
        viewController?.reloadData()
    }
}
