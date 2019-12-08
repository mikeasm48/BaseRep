//
//  Presenter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol ListPresenterProtocol: ModulePresenterProtocol {
}

class ListPresenter: ListPresenterProtocol {
    weak var viewController: ListViewController?

    func presentData (data: [MovieDataModel], imageData: [String: Data]) {
        viewController?.didLoadData(movies: data, images: imageData.mapValues{UIImage(data: $0)})
    }
}
