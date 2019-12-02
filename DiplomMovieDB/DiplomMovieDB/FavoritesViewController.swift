//
//  FavoritesViewController.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol FavoritesViewControllerProtocol {
}

class FavoritesViewController: UIViewController, FavoritesViewControllerProtocol {
    var interactor: FavoritesInteractorProtocol?
    var router: FavoritesRouterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}
