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
    func setDetails(movie: MovieDataModel, posterData: Data?, backdropData: Data?, savedState: Bool)
    func setMovieSavedState(_ state: Bool)
}

/// Презентер модуля деталей фильма
class DetailsPresenter: DetailsPresenterProtocol {
    var viewController: DetailsViewControllerProtocol?
    var detailsViewFactory: DetailsViewFactoryProtocol?

    func setDetails(movie: MovieDataModel, posterData: Data?, backdropData: Data?, savedState: Bool) {
        guard let poster = posterData else {
            return
        }
        guard let backdrop = backdropData else {
            return
        }

        guard let factory = detailsViewFactory else {
            return
        }

        factory.buildDetailsView(movieData: movie,
                                  poster: UIImage(data: poster),
                                  backdrop: UIImage(data: backdrop),
                                  savedState: savedState)
        viewController?.setScrollView(scrollView: factory.getScrollView())
        viewController?.setPosterForZoom(poster: factory.getPosterForZoom(), tapView: factory.getPosterViewForZoom())
        viewController?.initSaveButton()
        viewController?.didCheckCoreDataState(savedState)
    }

    func setMovieSavedState(_ state: Bool) {
        viewController?.didCheckCoreDataState(state)
    }
}
