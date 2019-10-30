//
//  StageViewController.swift
//  HomeWorkDashBoard
//
//  Created by Михаил Асмаковец on 30.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class StageView: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    //var delegate: ISSBottomMenuDelegate?
    
    var collectionView: UICollectionView!
    var isToggled: Bool = false;
    let cellHeight: CGFloat = 50.0
    let cellSpacing: CGFloat = 10.0
    let cellSectionSpacing: CGFloat = 15.0
    
    let itemsArray: Array<String> = {
        let array: Array<String> = ["TASK-1", "TASK-2", "TASK-3","TASK-4", "TASK-5", "TASK-6", "TASK-7", "TASK-8", "TASK-9", "TASK-10","TASK-1", "TASK-2", "TASK-3","TASK-4", "TASK-5", "TASK-6", "TASK-7", "TASK-8", "TASK-9", "TASK-10"]
        return array
    }()
    
    var collectionViewHeight:CGFloat {
        return (cellHeight + cellSpacing)  * CGFloat(itemsArray.count)
    }
    
    override init() {
        super.init()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .lightGray
        collectionView.register(TaskItemCollectionViewCell.self, forCellWithReuseIdentifier: "menuCell")
        
    }
    
    public func setPosition(x: CGFloat, y: CGFloat){
        var viewWidth: CGFloat = 0
        if let window = UIApplication.shared.windows.first {
            window.addSubview(collectionView)
            //TODO calculate size better!
            viewWidth = window.frame.size.width / 4
            let fitHeight = self.collectionViewHeight > window.frame.size.height ? window.frame.size.height : self.collectionViewHeight
            collectionView.frame = CGRect(x: x, y: y, width: viewWidth, height: fitHeight - 100)
        }
    //TODO добавить заголовок, который не скролится
//        let textLabel = UILabel()
//        textLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
//        textLabel.textAlignment = .center
//        textLabel.textColor = .blue
//        textLabel.text = "ToDo"
//        collectionView.addSubview(textLabel)
//        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: viewWidth, height: 10))
//        navBar.backgroundColor = collectionView.backgroundColor
//        collectionView.addSubview(navBar)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as! TaskItemCollectionViewCell
        cell.backgroundColor = .yellow;
        cell.textLabel.text = itemsArray[indexPath.row]
        cell.picture.image = UIImage(named: itemsArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSize = collectionView.frame.width / 2 - 20
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newFlowLayout = UICollectionViewFlowLayout()
        newFlowLayout.scrollDirection = .vertical
        collectionView.setCollectionViewLayout(newFlowLayout, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSectionSpacing, left: cellSectionSpacing, bottom: cellSectionSpacing, right: cellSectionSpacing)
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
//        UIView.animate(withDuration: 0.5){
//            cell.transform = .identity
//        }
//    }

}
