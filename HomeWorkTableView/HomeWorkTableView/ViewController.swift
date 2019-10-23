//
//  ViewController.swift
//  HomeWorkTableView
//
//  Created by Михаил Асмаковец on 21.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    var timer: Timer?
    
    var dataSource: DataSource?
    
    let textField : UITextField = {
        
        let textField = UITextField(frame: CGRect(x: 25.0, y: 300.0, width: 300.0, height: 40.0))
        return textField
    }()
    
    func getTextToEdit () -> String {
        guard let text = dataSource?.getCurrentData() else {
            return "no text to edit"
        }
        return text
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let textToEdit = getTextToEdit()
        print(textToEdit)
        textField.text = textToEdit
        //button.setTitle(textToEdit, for: .normal)
        view.backgroundColor = UIColor.cyan
        navigationController?.delegate = self
        
        view.addSubview(textField)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        print(viewController)
        guard let text = textField.text else {
            return
        }
        dataSource?.setCurrentData(text)
    }
    
}

