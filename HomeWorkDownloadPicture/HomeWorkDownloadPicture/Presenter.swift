//
//  Presenter.swift
//  HomeWorkDownloadPicture
//
//  Created by Михаил Асмаковец on 28.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol PresenterInputProtocol {
    func showPicture()
    func clearCachedPicture()
}

protocol PresenterOutputProtocol {
    func showLoadedPicture(picture: UIImage)
    func showError (error: String)
}

class Presenter: PresenterInputProtocol, InteractorOutputProtocol {
    var interactor : InteractorInputProtocol?
    var output : PresenterOutputProtocol?
    
    func showPicture () {
        interactor?.loadPicture()
    }
    
    func setPicture(picture: UIImage) {
        output?.showLoadedPicture(picture: picture)
    }
    
    func clearCachedPicture(){
        interactor?.clearCache()
    }
    
    func errorGetPicture(errorText: String) {
        output?.showError(error: errorText)
    }
}
