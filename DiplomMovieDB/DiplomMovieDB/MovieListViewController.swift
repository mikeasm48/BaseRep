//
//  MovieListViewController.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 05.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//
import UIKit

class MovieListViewController: UIViewController {
    var dataHolder: MovieDataHolderProtocol?
    
    func getDataHolder() -> MovieDataHolderProtocol{
        guard let dataHolder = self.dataHolder else {
            return MovieDataHolder()
        }
        return dataHolder
    }
}
