//
//  ImageFactory.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 04.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

final class ImageFactory {
    func getImage(for name: String) -> UIImage? {
        guard let pictureData =  DataModel.shared.getPicture(for: name) else {
           return nil
        }
        return UIImage(data: pictureData)
    }
}
