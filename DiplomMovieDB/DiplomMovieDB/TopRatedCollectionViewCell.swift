//
//  TopRatedCellView.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

/// Ячейка элемента коолекции модуля самых поплярных
class TopRatedCollectionViewCell: UICollectionViewCell {
    let textLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    let picture: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        picture.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        contentView.addSubview(picture)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        picture.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        picture.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }}
