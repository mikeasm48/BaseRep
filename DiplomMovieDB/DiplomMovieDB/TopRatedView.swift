//
//  TopRatedView.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class TopRatedView: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    var collectionView: UICollectionView!

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieModel.shared.getTopRated().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as? TopRatedCollectionViewCell else {
            return UICollectionViewCell(frame: CGRect(x: 0, y: 0, width: 20, height: 10))
        }

        cell.picture.image = MovieModel.shared.getTopRated()[indexPath.row].image
        return cell
    }
}
