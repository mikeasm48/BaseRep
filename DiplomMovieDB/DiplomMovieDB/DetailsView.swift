//
//  MovieDetailViewController.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class DetailsView: UIViewController {

    var movieData: PresenterOutputDataType?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }

    func setMovieData(detailModel: PresenterOutputDataType) {
        movieData = detailModel
    }
}
