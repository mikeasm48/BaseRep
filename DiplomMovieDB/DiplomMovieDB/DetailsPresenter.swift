//
//  DetailsPresenter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 30.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol DetailsPresenterProtocol {
    func showDetails(at movieId: Int, imageData: Data)
}

class DetailsPresenter: DetailsPresenterProtocol {
    var viewController: DetailsViewController?
    func showDetails(at movieId: Int, imageData: Data) {
        //TODO
    }
}
