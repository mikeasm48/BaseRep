//
//  TaskItem.swift
//  HomeWorkDashBoard
//
//  Created by Михаил Асмаковец on 30.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

//Task Item
class TaskItemCollectionViewCell: UICollectionViewCell {
    
    let textLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    
    let picture: UIImageView = {
        let imageView = UIImageView()
        return  imageView
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        textLabel.textAlignment = .center
        textLabel.textColor = .blue
        contentView.addSubview(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

