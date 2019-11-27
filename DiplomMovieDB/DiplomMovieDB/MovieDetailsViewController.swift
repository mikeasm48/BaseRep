//
//  MovieDetailViewController.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var movieData: MovieDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    
    func setMovieData(detailModel: MovieDetailViewModel) {
        movieData = detailModel
    }
}
