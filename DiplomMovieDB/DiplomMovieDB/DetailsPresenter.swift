//
//  DetailsPresenter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 30.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

/// Протокол презентера  модуля деталей фильма
protocol DetailsPresenterProtocol {
    func setDetails(posterData: Data?, backdropData: Data?, savedState: Bool)
    func setMovieSavedState(_ state: Bool)
}

/// Презентер модуля деталей фильма
class DetailsPresenter: DetailsPresenterProtocol {
    var viewController: DetailsViewControllerProtocol?

    func setDetails(posterData: Data?, backdropData: Data?, savedState: Bool) {
        guard let poster = posterData else {
            return
        }
        guard let backdrop = backdropData else {
            return
        }
        viewController?.didShowDetails(poster: UIImage(data: poster), backdrop: UIImage(data: backdrop), savedState: savedState)
    }

    func setMovieSavedState(_ state: Bool) {
        viewController?.didCheckCoreDataState(state)
    }
}
