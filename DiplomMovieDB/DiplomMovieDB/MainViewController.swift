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
        //TODO поставить .white чтобы не заморачиваться с ресайзом разных объектов типа UITextView в заголовке листа на главном экране
        view.backgroundColor = .white
        navigationItem.title = "Популярные"
    }
}
