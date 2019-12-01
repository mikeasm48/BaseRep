//
//  DetailsInteractor.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 30.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

class DetailsInteractor: InteractorInputProtocol {
    var interactorOutput: InteractorOutputProtocol?
    let networkService: NetworkServiceInput

    init(networkService: NetworkServiceInput) {
        self.networkService = networkService
    }

    func setOutput(output: InteractorOutputProtocol) {
        self.interactorOutput = output
    }

    func loadDataAsync() {
        //TODO
    }
}
