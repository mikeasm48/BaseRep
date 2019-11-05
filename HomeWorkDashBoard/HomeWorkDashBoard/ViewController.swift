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
        [StageHolder(stageName: "Входящие задачи", stage: StageView.init()),
         StageHolder(stageName: "В процессе", stage: StageView.init()),
         StageHolder(stageName: "На проверке", stage: StageView.init()),
         StageHolder(stageName: "Готово", stage: StageView.init())]

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after loading the view.
        let screenWidth:Int = Int(self.view.frame.width)

        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 40, width: screenWidth, height: 40))
        navigationBar.backgroundColor = .lightText
        let barItemAdd = UIBarButtonItem(title: "Добавить", style: UIBarButtonItem.Style.plain, target: self, action: nil)
         let barItemDel = UIBarButtonItem(title: "Удалить", style: UIBarButtonItem.Style.plain, target: self, action: nil)
        barItemAdd.action = #selector(addTaskItemAction)
        barItemDel.action = #selector(removeTaskItemAction)
        let addTaskButton = UINavigationItem(title: "TreLoLo")
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
            let stageViewCount = CGFloat(stages.count)
            let stageViewWidth = (self.view.frame.size.width / stageViewCount) - 20
            
            let stageLabel = UILabel(frame: CGRect(x: deltaX, y: stageViewUpperBound, width: stageViewWidth, height: 40))
            stageLabel.backgroundColor = navigationBar.backgroundColor
            stageLabel.textAlignment = .center
            stageLabel.text = stageHolder.stageName
            self.view.addSubview(stageLabel)
            stageHolder.stage?.setPosition(x: deltaX, y: stageViewUpperBound + 40, width: stageViewWidth)
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

