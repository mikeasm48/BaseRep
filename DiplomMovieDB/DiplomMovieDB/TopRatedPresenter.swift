//
//  TopRatedPresenter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//
import UIKit

protocol TopRatedPresenterProtocol {
    func reloadData(data: [MovieDataModel], imageData: [String: Data])
}

class TopRatedPresenter: TopRatedPresenterProtocol {
    var viewController: TopRatedViewController?

    func reloadData(data: [MovieDataModel], imageData: [String: Data]) {
        viewController?.didLoadData(movies: data,
                                    images: imageData.mapValues{UIImage(data: $0)})
    }
}
