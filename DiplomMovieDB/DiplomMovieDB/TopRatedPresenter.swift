//
//  TopRatedPresenter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//
import UIKit

protocol TopRatedPresenterProtocol {
    func reloadData()
}

class TopRatedPresenter: TopRatedPresenterProtocol {
    var viewController: TopRatedViewController?

    func reloadData() {
        viewController?.reloadData()
    }
}
