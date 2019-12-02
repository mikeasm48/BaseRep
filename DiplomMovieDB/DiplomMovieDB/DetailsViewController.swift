//
//  MovieDetailViewController.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol DetailsViewControllerProtocol {
    
}

class DetailsViewController: UIViewController, DetailsViewControllerProtocol {
    var interactor: DetailsInteractorProtocol?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}
