//
//  DetailsPresenter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 30.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol DetailsPresenterProtocol {
    func setPictures(posterData: Data?, backdropData: Data?)
    func setMovieSavedState(_ state: Bool)
}

class DetailsPresenter: DetailsPresenterProtocol {
    var viewController: DetailsViewControllerProtocol?

    func setPictures(posterData: Data?, backdropData: Data?) {
        guard let poster = posterData else {
            return
        }
        guard let backdrop = backdropData else {
            return
        }
        viewController?.didShowDetails(poster: UIImage(data: poster), backdrop: UIImage(data: backdrop))
    }

    func setMovieSavedState(_ state: Bool) {
        viewController?.didCheckCoreDataState(state)
    }
}
