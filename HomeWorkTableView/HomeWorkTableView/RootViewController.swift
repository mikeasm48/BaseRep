//
//  RootViewController.swift
//  HomeWorkTableView
//
//  Created by Михаил Асмаковец on 23.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UITableViewDelegate {
    
    let viewController : ViewController = ViewController()
    
    let dataSource = DataSource()
    let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor.red
        view.addSubview(tableView)
        tableView.reloadData()
    }
    
    private func updateLayout (with size: CGSize){
        tableView.frame = CGRect.init(origin: .zero, size: size)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        updateLayout(with: view.frame.size)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        viewController.dataSource = dataSource
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource.setCurrent(indexPath.section, element: indexPath.row)
        pushViewToEdit()
    }
    
    
    func pushViewToEdit () {
        let transition = CATransition()
        transition.duration = 1.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        navigationController?.view.layer.add(transition, forKey: "transition")
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    class TableViewCell: UITableViewCell {
        override func prepareForReuse() {
            super.prepareForReuse()
            self.accessoryType = .none
        }
    }
}
