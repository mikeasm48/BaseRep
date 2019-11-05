//
//  StageViewController.swift
//  HomeWorkDashBoard
//
//  Created by Михаил Асмаковец on 30.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

struct TaskItemType {
    var taskName : String
    var taskDescription: String
    init(task: String, description: String) {
        taskName = task
        taskDescription = description
    }
}

class StageView: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    var exchangeHelper: ExchangeItemHelper?
    
    var collectionView: UICollectionView!
    
    var lastStageCounter = 0

    let cellHeight: CGFloat = 90.0
    let cellSpacing: CGFloat = 10.0
    let cellSectionSpacing: CGFloat = 15.0
    
    var itemsArray: Array<TaskItemType> = {
        let array: Array<TaskItemType> = []
        return array
    }()
    
    var collectionViewHeight:CGFloat {
        let height = itemsArray.count < 10 ? 10 : itemsArray.count
        return (cellHeight + cellSpacing)  * CGFloat(height)
    }
    //Добавление задачи
    func addTask () {
        lastStageCounter += 1
        itemsArray.append(TaskItemType(task: "Task-" + String(lastStageCounter), description: ""))
        
        collectionView.reloadData()
    }
    
    //Удаление выбранной задачи
    func removeSelectedTask () {
        guard let items = collectionView.indexPathsForSelectedItems else {
            return
        }
        for item in  items {
            itemsArray.remove(at: item.row)
        }
        collectionView.reloadData()
    }
    
    override init() {
        super.init()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        //Drag&Drop
        collectionView.dragInteractionEnabled = true
        collectionView.dragDelegate = self;
        collectionView.dropDelegate = self;
        
        collectionView.backgroundColor = .lightGray
        collectionView.register(TaskItemCollectionViewCell.self, forCellWithReuseIdentifier: "menuCell")
    }
    
    public func setPosition(x: CGFloat, y: CGFloat, width: CGFloat){
        if let window = UIApplication.shared.windows.first {
            window.addSubview(collectionView)
            let fitHeight = self.collectionViewHeight > window.frame.size.height ? window.frame.size.height : self.collectionViewHeight
            collectionView.frame = CGRect(x: x, y: y, width: width, height: fitHeight - 120)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as! TaskItemCollectionViewCell
        if (cell.isSelected){
            cell.textLabel.textColor = .blue
        } else {
            cell.textLabel.textColor = .black
        }
        cell.backgroundColor = .yellow;
        
        cell.currentRow = indexPath.row
        cell.currentStageView = self
        cell.textLabel.text = itemsArray[indexPath.row].taskName
        cell.itemDescription.text = itemsArray[indexPath.row].taskDescription
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //let cellSize = collectionView.frame.width / 2 - 20
        let cellSize = cellHeight
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
   
    //Переключаем выбор ячейки
    private func swithCellSelection(_ collectionView: UICollectionView, indexPath: IndexPath) -> Bool {
        guard let selected = collectionView.cellForItem(at: indexPath)?.isSelected else {
            return true
        }
        if (selected) {
            collectionView.deselectItem(at: indexPath, animated: false)
            return false
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let needSelect = swithCellSelection(collectionView, indexPath: indexPath)
        collectionView.reloadData()
        return needSelect
    }
}

//Drag & Drop
//Drag
extension StageView: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = self.itemsArray[indexPath.row].taskName
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        exchangeHelper?.sourceStageView = self
        exchangeHelper?.sourceIndexPath = indexPath
        return [dragItem]
    }
}

//Drop
extension StageView : UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool
    {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal
    {
        exchangeHelper?.destinationStageView = self
        return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator)
    {
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath
        {
            destinationIndexPath = indexPath
        }
        else
        {
            let section = collectionView.numberOfSections - 1
            let row = collectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        guard let helper = exchangeHelper else {
            return
        }
        
        switch coordinator.proposal.operation
        {
        case .move:
            helper.processTransaction(coordinator: coordinator, destinationIndexPath:destinationIndexPath)
            break
        default:
            return
        }
    }
}
