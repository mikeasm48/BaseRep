//
//  ExchangeItemHelper.swift
//  HomeWorkDashBoard
//
//  Created by Михаил Асмаковец on 01.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit
/*
 * Посредник для обмена экземплярами TaskItem между view
 */
class ExchangeItemHelper {
    var sourceStageView : StageView?
    var destinationStageView : StageView?
    //Для переноса между view, в координаторе в этом случае нет этих данных
    var sourceIndexPath: IndexPath?
    
    func processTransaction (coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath)
    {
        guard let source = sourceStageView else {
            print("ExchangeItemHelper: источник не инициализирован")
            return
        }
        
        guard let destination = destinationStageView else {
            print("ExchangeItemHelper: приемник не инициализирован")
            return
        }
        moveItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, source: source, destination: destination)
    }
    
    //Переносит TaskItem между и внутри view
    private func moveItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, source: StageView, destination: StageView)
    {
        let items = coordinator.items
        if items.count == 1, let _ = items.first, let sourceIndexPath = self.sourceIndexPath
        {
            var dIndexPath = destinationIndexPath
            if dIndexPath.row >= destination.collectionView.numberOfItems(inSection: 0)
            {
                dIndexPath.row = destination.collectionView.numberOfItems(inSection: 0) - 1
            }
            if (dIndexPath.row < 0 ){
                dIndexPath.row = 0
            }
            destination.collectionView.performBatchUpdates({
                let taskToMove = source.itemsArray[sourceIndexPath.row]
                source.itemsArray.remove(at: sourceIndexPath.row)
                
                destination.itemsArray.insert(taskToMove, at: dIndexPath.row)
                source.collectionView.deleteItems(at: [sourceIndexPath])
                destination.collectionView.insertItems(at: [dIndexPath])
            })
        }
    }
}
