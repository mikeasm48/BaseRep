//
//  ViewController.swift
//  HomeWorkDashBoard
//
//  Created by Михаил Асмаковец on 30.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView()
    let toDoStageView = StageView.init()
    let inProgressStageView = StageView.init()
    let reviewStageView = StageView.init()
    let inQAStageView = StageView.init()
    let doneStageView = StageView.init()
//    override func viewDidLoad() {
//        super.viewDidLoad()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after loading the view.
        
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        navigationBar.backgroundColor = .lightText
        let addTaskButton = UINavigationItem(title: "Добавить задачу")
        navigationBar.items = [addTaskButton]
        self.view.addSubview(navigationBar)
        //Init Stages
        let stageViewUpperBound = navigationBar.frame.height + 10
        let stageViewWidth = 350
        toDoStageView.setPosition(x: 10, y: stageViewUpperBound)
        inProgressStageView.setPosition(x: CGFloat(10 + stageViewWidth), y: stageViewUpperBound)
        reviewStageView.setPosition(x: CGFloat(10 + stageViewWidth * 2), y: stageViewUpperBound)
        inQAStageView.setPosition(x: CGFloat(10 + stageViewWidth * 3), y: stageViewUpperBound)
        doneStageView.setPosition(x: CGFloat(10 + stageViewWidth * 4), y: stageViewUpperBound)
    

    }


}

