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
    var router: MainRouterProtocol?
    var topRatedViewController: UIViewController?
    var recentListViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Популярные"
        guard let top = topRatedViewController else {
            return
        }

        guard let list = recentListViewController else {
            return
        }
        addChild(top)
        view.addSubview(top.view)
        addChild(list)
        view.addSubview(list.view)

        top.view.translatesAutoresizingMaskIntoConstraints = false
        list.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //TopRated
            top.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            top.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            top.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            top.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                                constant: view.frame.height / 3),
            //List
            list.view.topAnchor.constraint(equalTo: top.view.bottomAnchor),
            list.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            list.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            list.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
}
