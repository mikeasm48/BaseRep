//
//  InteractorProtocol.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 28.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

protocol InteractorInputProtocol {
    func setOutput(output: InteractorOutputProtocol)
    func loadDataAsync()
}

protocol InteractorOutputProtocol {
    func reloadData (data: [InteractorOutputDataType])
}
