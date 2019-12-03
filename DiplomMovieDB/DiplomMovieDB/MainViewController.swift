//
//  MainViewController.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol MainViewControllerProtocol {
}

class MainViewController: UIViewController, MainViewControllerProtocol {
//    var interactor: MainInteractorProtocol?
    var router: MainRouterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        navigationItem.title = "Список фильмов"
    }
}
