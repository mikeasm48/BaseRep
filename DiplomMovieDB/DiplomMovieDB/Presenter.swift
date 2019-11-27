//
//  Presenter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol PresenterInput {
    func showMovieDetails(movie: MovieItemModel)
    func showMovieDefaultList()
    func search(by: String)
}

protocol PresenterOutput {
    func showMovieDetails(detailMovie: MovieDetailViewModel)
    func reloadMovieList(movieViewList: [MovieViewModel])
}

class Presenter: PresenterInput, InteractorOutput {
    let interactor: InteractorInput
    var output: PresenterOutput?

    init (interactor: InteractorInput) {
        self.interactor = interactor
        self.output = nil
    }

    func showMovieDetails(movie: MovieItemModel) {
        //TODO
    }

    func showMovieDefaultList(){
        //TODO
    }
    
    func search(by: String){
        //TODO
    }
}
