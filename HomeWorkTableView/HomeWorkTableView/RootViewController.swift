//
//  RootViewController.swift
//  HomeWorkTableView
//
//  Created by Михаил Асмаковец on 23.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UITableViewDelegate {
    //Контроллер для редактирования
    let viewController : ViewController = ViewController()
    //DS
    let dataSource = DataSource()
    //Таблица
    let myTableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor.red
        view.addSubview(myTableView)
        myTableView.reloadData()
    }
    
    private func updateLayout (with size: CGSize){
        myTableView.frame = CGRect.init(origin: .zero, size: size)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        updateLayout(with: view.frame.size)
        myTableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        myTableView.dataSource = dataSource
        myTableView.delegate = self
        
        viewController.dataSource = dataSource
    }
    
    
    
    //Устанавливаем кастомную высоту первой строки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let minimumHeightForFirst = CGFloat(80)
        let minimumHeight = CGFloat(40)
        
        print(indexPath.section.description + "/" + indexPath.row.description)
        //print(tableView.numberOfRows(inSection: indexPath.section))
        //!!!!!Здесь всегда идет в ELSE
        guard let cell = tableView.cellForRow(at: indexPath) else {
            if (indexPath.section == 0){
                return minimumHeightForFirst
            }
            return minimumHeight
        }

        
        //        let cellLength = cell.textLabel!.frame.size.width
        
//        let cellLength = CGFloat(300)
//        let label = UILabel(frame: tableView.frame)
//        label.text = dataSource.getData(for: indexPath)
//        let calculatedCellSize = label.sizeThatFits(CGSize(width: cellLength, height: CGFloat.greatestFiniteMagnitude))
        //dfprint (calculatedCellSize)
        //return calculatedCellSize.height
        return UITableView.automaticDimension
    }
    
    //Передаем данные для редактирования
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource.setCurrent(indexPath.section, element: indexPath.row)
        pushViewToEdit()
    }
    //Пушится вьюха редактирования
    func pushViewToEdit () {
        // Аницация
        let transition = CATransition()
        transition.duration = 1.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        navigationController?.view.layer.add(transition, forKey: "transition")
        //Push
        navigationController?.pushViewController(viewController, animated: true)
    }
}
