//
//  TopRatedPresenter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//
import UIKit

protocol TopRatedPresenterProtocol: ModulePresenterProtocol {
}

class TopRatedPresenter: TopRatedPresenterProtocol {
    var viewController: TopRatedViewController?

    func presentData(data: [MovieDataModel], imageData: [String: Data]) {
        viewController?.didLoadData(movies: data,
                                    images: imageData.mapValues{UIImage(data: $0)})
    }
}
