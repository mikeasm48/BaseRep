//
//  TaskItem.swift
//  HomeWorkDashBoard
//
//  Created by Михаил Асмаковец on 30.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

//Task Item
class TaskItemCollectionViewCell: UICollectionViewCell, UITextViewDelegate {
    
    var currentRow: Int?
    var currentStageView: StageView?
    
    let textLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let itemDescription = UITextView(frame: CGRect(x: 0, y: 10, width: 20, height: 10))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textLabel.frame = CGRect(x: 10, y: 0, width: frame.size.width, height: 20)
        textLabel.textAlignment = .left
        textLabel.textColor = .black
        contentView.addSubview(textLabel)
        itemDescription.frame = CGRect(x: 0, y: 20, width: frame.size.width, height: frame.size.height - 20)
        itemDescription.delegate = self
        contentView.addSubview(itemDescription)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let stageView = currentStageView else {
            return
        }
        
        guard let cellRow = currentRow else {
            return
        }
        if (cellRow > stageView.itemsArray.count) {
            return
        }
        stageView.itemsArray[cellRow].taskDescription = textView.text
    }
    
}

