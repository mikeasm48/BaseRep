//
//  ViewController.swift
//  HomeWorkDashBoard
//
//  Created by Михаил Асмаковец on 30.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

struct StageHolder {
    var stageName : String
    var stage : StageView?
}

class ViewController: UIViewController, UIScrollViewDelegate {
    var stages =
        [StageHolder(stageName: "ToDo", stage: StageView.init()),
         StageHolder(stageName: "InProgress", stage: StageView.init()),
         StageHolder(stageName: "Done", stage: StageView.init())]

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after loading the view.
        let screenWidth:Int = Int(self.view.frame.width)

        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 40, width: screenWidth, height: 40))
        navigationBar.backgroundColor = .lightText
//        let barItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: nil)
        let barItemAdd = UIBarButtonItem(title: "Добавить", style: UIBarButtonItem.Style.plain, target: self, action: nil)
         let barItemDel = UIBarButtonItem(title: "Удалить", style: UIBarButtonItem.Style.plain, target: self, action: nil)
        barItemAdd.action = #selector(addTaskItemAction)
        barItemDel.action = #selector(removeTaskItemAction)
        let addTaskButton = UINavigationItem(title: "Баг трекер")
        addTaskButton.leftBarButtonItems = [barItemAdd, barItemDel]

        navigationBar.items = [addTaskButton]
        self.view.addSubview(navigationBar)
        
        //Init Stages
        let stageViewUpperBound = navigationBar.frame.minY + navigationBar.frame.height + 20
        let stageViewWidth = (screenWidth + (stages.count))/stages.count
        var stageCounter = 0
        let exchanhgeHeplper = ExchangeItemHelper()
        for stageHolder in stages {
            let deltaX = CGFloat(10 + stageViewWidth * stageCounter)
            stageHolder.stage?.setPosition(x: deltaX, y: stageViewUpperBound)
            stageHolder.stage?.exchangeHelper = exchanhgeHeplper
            stageCounter += 1
            if (stageCounter == 1) {
                stageHolder.stage?.addTask()
                stageHolder.stage?.addTask()
                stageHolder.stage?.addTask()
                stageHolder.stage?.addTask()
                stageHolder.stage?.addTask()
            }
        }
    }
    
    //Добавление задачи
    @objc func addTaskItemAction() {
        stages[0].stage?.addTask()
    }
    
    //Удаление задачи
    @objc func removeTaskItemAction() {
        for stageHolder in stages {
            stageHolder.stage?.removeSelectedTask()
        }
    }
}

