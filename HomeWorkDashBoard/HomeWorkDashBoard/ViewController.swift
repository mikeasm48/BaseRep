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

    var stages = [StageHolder(stageName: "ToDo", stage: StageView.init()),
    StageHolder(stageName: "InProgress", stage: StageView.init()),
    StageHolder(stageName: "Done", stage: StageView.init())]

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after loading the view.
        let screenWidth:Int = Int(self.view.frame.width)
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 50))
        navigationBar.backgroundColor = .lightText
        let addTaskButton = UINavigationItem(title: "Добавить задачу")
        navigationBar.items = [addTaskButton]
        self.view.addSubview(navigationBar)
        //Init Stages
        let stageViewUpperBound = navigationBar.frame.height + 10
        let stageViewWidth = (screenWidth + (stages.count))/stages.count
        var stageCounter = 0
        for stageHolder in stages {
            let deltaX = CGFloat(10 + stageViewWidth * stageCounter)
            stageHolder.stage?.setPosition(x: deltaX, y: stageViewUpperBound)
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


}

