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
    //var isToggled: Bool = false;
    //TODO изменяяем на 20 - полэкрана, ставим 50 - и на весь экран по вышине! разобраться
    let cellHeight: CGFloat = 100.0
    let cellSpacing: CGFloat = 10.0
    let cellSectionSpacing: CGFloat = 15.0
    
    var itemsArray: Array<String> = {
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
        //Drag&Drop
        collectionView.dragInteractionEnabled = true
        collectionView.dragDelegate = self;
        collectionView.dropDelegate = self;
        
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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as! TaskItemCollectionViewCell
        cell.backgroundColor = .yellow;
        cell.textLabel.text = itemsArray[indexPath.row]
        //cell.picture.image = UIImage(named: itemsArray[indexPath.row])
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
    
    //For Drag&Drop
    private func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView)
    {
        let items = coordinator.items
        if items.count == 1, let item = items.first, let sourceIndexPath = item.sourceIndexPath
        {
            var dIndexPath = destinationIndexPath
            if dIndexPath.row >= collectionView.numberOfItems(inSection: 0)
            {
                dIndexPath.row = collectionView.numberOfItems(inSection: 0) - 1
            }
            collectionView.performBatchUpdates({
                self.itemsArray.remove(at: sourceIndexPath.row)
                self.itemsArray.insert(item.dragItem.localObject as! String, at: dIndexPath.row)
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [dIndexPath])
            })
            coordinator.drop(items.first!.dragItem, toItemAt: dIndexPath)
        }
    }

}

//Drag & Drop
//Drag
extension StageView: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = self.itemsArray[indexPath.row]
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        
        return [dragItem]
    }
    
    //func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters?
    //{
    //        let previewParameters = UIDragPreviewParameters()
    //        previewParameters.visiblePath = UIBezierPath(rect: CGRect(x: 25, y: 25, width: 120, height: 120))
    //        return previewParameters
    //}
}


//Drop
extension StageView : UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool
    {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal
    {
        if collectionView.hasActiveDrag
        {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        else
        {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
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
        
        switch coordinator.proposal.operation
        {
        case .move:
            self.reorderItems(coordinator: coordinator, destinationIndexPath:destinationIndexPath, collectionView: collectionView)
            break
        default:
            return
        }
    }
}
