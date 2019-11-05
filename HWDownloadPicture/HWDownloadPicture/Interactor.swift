//
//  Interactor.swift
//  HomeWorkDownloadPicture
//
//  Created by Михаил Асмаковец on 28.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol InteractorInputProtocol {
    func loadPicture()
    func loadPictureWithError()
    func clearCache()
}

protocol InteractorOutputProtocol {
    func setPicture (picture: UIImage)
    func errorGetPicture(errorText: String)
}

class Interactor: InteractorInputProtocol {
    var output: InteractorOutputProtocol?
    let cache = NSCache<NSString, UIImage>()
    let defaultURL = "http://icons.iconarchive.com/icons/dtafalonso/ios8/512/Calendar-icon.png"
    let wrongURL = "http://noicons.noiconarchive.com/_icons/dtafalonsoxxx/ios8/512/Calendar-icon.png"
    var currentURL = ""
    
    func clearCache() {
        cache.removeAllObjects()
        print("clear cache")
    }
    
    func downloadImage(completion: @escaping (UIImage?, Error?) -> Void) {
        guard let url = URL(string:currentURL) else { return }
        
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
        processLoadingPicture(url: defaultURL)
    }
    
    func loadPictureWithError() {
        processLoadingPicture(url: wrongURL)
    }
    
    private func processLoadingPicture (url: String){
        currentURL = url
        let cacheKey: NSString = "CachedImage"
        if let cachedImage = cache.object(forKey: cacheKey){
            self.output?.setPicture(picture: cachedImage)
            print("have got pictire from cache")
        } else {
            downloadImage { image, error in
                if  (error != nil) {
                    self.output?.errorGetPicture(errorText: "Невозможно загрузить изображение")
                    print("что-то пошло не так, валимся с ошибкой")
                    return
                }
                DispatchQueue.main.async {
                    self.cache.setObject(image!, forKey: cacheKey)
                    self.output?.setPicture(picture: image!)
                    print("have got pictire from intenet")
                }
            }
        }
    }
}
