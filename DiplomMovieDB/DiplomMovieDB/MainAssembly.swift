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
        let searchViewController = SearchAssembly.build()
        let topRatedViewController = TopRatedAssembly.build()

        mainViewController.addChild(searchViewController)
        mainViewController.view.addSubview(searchViewController.view)
        mainViewController.addChild(listViewController)
        mainViewController.view.addSubview(listViewController.view)
        mainViewController.addChild(topRatedViewController)
        mainViewController.view.addSubview(topRatedViewController.view)

        searchViewController.view.translatesAutoresizingMaskIntoConstraints = false
        listViewController.view.translatesAutoresizingMaskIntoConstraints = false
        topRatedViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            //Search
            searchViewController.view.topAnchor.constraint(equalTo: mainViewController.view.safeAreaLayoutGuide.topAnchor),
            searchViewController.view.leftAnchor.constraint(equalTo: mainViewController.view.leftAnchor),
            searchViewController.view.rightAnchor.constraint(equalTo: mainViewController.view.rightAnchor),
            searchViewController.view.bottomAnchor.constraint(equalTo: mainViewController.view.safeAreaLayoutGuide.topAnchor,
                                                              constant: 50),
            //TopRated
            topRatedViewController.view.topAnchor.constraint(equalTo: searchViewController.view.bottomAnchor),
            topRatedViewController.view.leftAnchor.constraint(equalTo: mainViewController.view.leftAnchor),
            topRatedViewController.view.rightAnchor.constraint(equalTo: mainViewController.view.rightAnchor),
            topRatedViewController.view.bottomAnchor.constraint(equalTo: searchViewController.view.bottomAnchor,
                                                                constant: 100),
            //List
            listViewController.view.topAnchor.constraint(equalTo: topRatedViewController.view.bottomAnchor, constant: 10),
            listViewController.view.leftAnchor.constraint(equalTo: mainViewController.view.leftAnchor),
            listViewController.view.rightAnchor.constraint(equalTo: mainViewController.view.rightAnchor),
            listViewController.view.bottomAnchor.constraint(equalTo: mainViewController.view.bottomAnchor)])

        _ = UINavigationController.init(rootViewController: mainViewController)

        return mainViewController
    }
}