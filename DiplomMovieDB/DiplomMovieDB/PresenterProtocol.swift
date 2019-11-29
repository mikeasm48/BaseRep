//
//  PresenterProtocol.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 28.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

protocol PresenterInputProtocol {
    func show()
    func search (by text: String)
}

protocol PresenterOutputProtocol {
    func didLoadData (data: [PresenterOutputDataType])
}
