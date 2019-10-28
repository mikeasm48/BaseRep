//
//  Interactor.swift
//  HomeWorkDownloadPicture
//
//  Created by Михаил Асмаковец on 28.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit
//TODO raise and process errors
//TODO cache operations
protocol InteractorInputProtocol {
    func loadPicture()
}

protocol InteractorOutputProtocol {
    func setPicture (picture: UIImage)
    
}

class Interactor: InteractorInputProtocol {
    var output: InteractorOutputProtocol?
    
    func downloadImage(completion: @escaping (UIImage?, Error?) -> Void) {
        guard let url = URL(string:"http://icons.iconarchive.com/icons/dtafalonso/ios8/512/Calendar-icon.png") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let currentError = error {
                completion(nil, currentError)
                return
            }
            
            guard let currentData = data else { return }
            let image = UIImage(data: currentData)
            completion(image, nil)
        }
        
        task.resume()
    }
    
    func loadPicture() {
        downloadImage { image, error in
            DispatchQueue.main.async {
                self.output?.setPicture(picture: image!)
            }
        }
    }
}
