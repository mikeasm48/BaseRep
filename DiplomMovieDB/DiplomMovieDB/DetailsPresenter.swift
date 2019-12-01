//
//  DetailsPresenter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 30.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class DetailsPresenter: PresenterInputProtocol {
    let interactor: InteractorInputProtocol
    var output: PresenterOutputProtocol?

    init (interactor: InteractorInputProtocol) {
        self.interactor = interactor
        self.output = nil
    }

    func show() {
        //TODO
    }

    func search(by text: String) {
        //Stub
    }
}

extension DetailsPresenter: InteractorOutputProtocol {
    func reloadData(data: [InteractorOutputDataType]) {
        //TODO
    }
}
