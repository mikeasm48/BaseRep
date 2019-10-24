//
//  ViewController.swift
//  HomeWorkTableView
//
//  Created by Михаил Асмаковец on 21.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    var dataSource: DataSource?
    
    let textField : UITextView = {
        let textField = UITextView(frame: CGRect(x: 10.0, y: 120.0, width: 300.0, height: 300.0))
        return textField
    }()
    
    //Безопасно распаквываем данные для редактирования
    func getTextToEdit () -> String {
        guard let text = dataSource?.getCurrentData() else {
            return "no text to edit"
        }
        return text
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.text = getTextToEdit()
        view.backgroundColor = UIColor.cyan
        navigationController?.delegate = self
        textField.frame = self.view.frame
        view.addSubview(textField)
    }
    
    //Вовзращаем отредактированные данные
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let text = textField.text else {
            return
        }
        dataSource?.setCurrentData(text)
    }
}

