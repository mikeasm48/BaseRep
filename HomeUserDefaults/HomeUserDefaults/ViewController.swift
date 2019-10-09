//
//  ViewController.swift
//  HomeUserDefaults
//
//  Created by Михаил Асмаковец on 09.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let intStore = HomeUserDefaultsGeneric <Int> ()
        let stringStore = HomeUserDefaultsGeneric <String> ()
        
        //Init data
        print("Init data")
        intStore.set(1, forKey: "keyInt")
        stringStore.set("dva", forKey: "keyString")
        
        //Get data
        print("Getting data")
        let resultInt = intStore.get("keyInt")
        intStore.printResult(resultInt)
        let resultString = stringStore.get("keyString")
        stringStore.printResult(resultString)
        
        //Clean
        print("Clean")
        intStore.remove("keyInt")
        stringStore.remove("keyString")
        //Check clean
        print("Checking clean")
        let cleanInt = intStore.get("keyInt")
        intStore.printResult(cleanInt)
        let cleanString = stringStore.get("keyString")
        stringStore.printResult(cleanString)
    }

}

extension HomeUserDefaultsGeneric{
    func printResult(_ forResult: Result<T, Error>){
            switch forResult {
            case .success(let resultValue):
                print("Result Success: \(resultValue)")
            case .failure(let error): print(error)
            }
    }
}
