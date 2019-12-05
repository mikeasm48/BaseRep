//
//  MainAssembly.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

final class MainAssembly: AssemblyProtocol {
    static func build() -> UIViewController {
        let mainViewController = MainViewController()
        let listViewController = ListAssembly.build()
        let topRatedViewController = TopRatedAssembly.build()

        mainViewController.addChild(topRatedViewController)
        mainViewController.view.addSubview(topRatedViewController.view)
        mainViewController.addChild(listViewController)
        mainViewController.view.addSubview(listViewController.view)

        listViewController.view.translatesAutoresizingMaskIntoConstraints = false
        topRatedViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            //TopRated
            topRatedViewController.view.topAnchor.constraint(equalTo: mainViewController.view.safeAreaLayoutGuide.topAnchor),
            topRatedViewController.view.leftAnchor.constraint(equalTo: mainViewController.view.leftAnchor),
            topRatedViewController.view.rightAnchor.constraint(equalTo: mainViewController.view.rightAnchor),
            topRatedViewController.view.bottomAnchor.constraint(equalTo: mainViewController.view.safeAreaLayoutGuide.topAnchor,
                                                                constant: 280),
            //List
            listViewController.view.topAnchor.constraint(equalTo: topRatedViewController.view.bottomAnchor),
            listViewController.view.leftAnchor.constraint(equalTo: mainViewController.view.leftAnchor),
            listViewController.view.rightAnchor.constraint(equalTo: mainViewController.view.rightAnchor),
            listViewController.view.bottomAnchor.constraint(equalTo: mainViewController.view.bottomAnchor)])

        _ = UINavigationController.init(rootViewController: mainViewController)

        return mainViewController
    }
}
