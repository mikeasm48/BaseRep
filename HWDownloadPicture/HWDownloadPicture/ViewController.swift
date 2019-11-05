//
//  ViewController.swift
//  HomeWorkDownloadPicture
//
//  Created by Михаил Асмаковец on 28.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var presenter: PresenterInputProtocol?
    var imageView = UIImageView ()
    
    let buttonShowPicture : UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Show Default Picture", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action:  #selector(tapButtonShowPicture), for:.touchDown)
        button.frame = CGRect(x: 100, y:150, width: 200.0, height: 40.0)
        return button
    }()
    
    let buttonLoadPicture : UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Load Picture", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action:  #selector(tapButtonLoadPicture), for:.touchDown)
        button.frame = CGRect(x: 100, y:200, width: 200.0, height: 40.0)
        return button
    }()
    
    let buttonLoadPictureError : UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Load Picture Error", for: .normal)
        button.backgroundColor = UIColor.red
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action:  #selector(tapButtonLoadPictureError), for:.touchDown)
        button.frame = CGRect(x: 100, y:250, width: 200.0, height: 40.0)
        return button
    }()
    
    let buttonClearCache : UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Clear Cache", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action:  #selector(tapButtonClearCache), for:.touchDown)
        button.frame = CGRect(x: 100, y:250, width: 200.0, height: 40.0)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenWidth = view.frame.size.width
        
        imageView.frame = CGRect(x: 0, y: 100, width: screenWidth, height: screenWidth)
        
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        initDefaultPicture()
        moveButtonToPositionY(button: buttonShowPicture, dY: screenWidth - 150)
        moveButtonToPositionY(button: buttonLoadPicture, dY: screenWidth - 100)
        moveButtonToPositionY(button: buttonLoadPictureError, dY: screenWidth - 50)
        moveButtonToPositionY(button: buttonClearCache, dY: screenWidth)
        view.addSubview(buttonShowPicture)
        view.addSubview(buttonLoadPicture)
        view.addSubview(buttonLoadPictureError)
        view.addSubview(buttonClearCache)
    }
    
    func moveButtonToPositionY(button: UIButton, dY: CGFloat){
        button.frame =  buttonClearCache.frame.offsetBy(dx: CGFloat(0), dy: CGFloat(dY))
    }
    
    func initDefaultPicture(){
        imageView.image = UIImage(named: "DefaultPicture")
    }
    
    @objc func tapButtonShowPicture () {
        initDefaultPicture()
        //TODO: do smth else
    }
    
    @objc func tapButtonLoadPicture () {
        presenter?.showPicture()
    }
    
    @objc func tapButtonLoadPictureError () {
        presenter?.showPictureWithProblem()
    }
    
    @objc func tapButtonClearCache () {
        presenter?.clearCachedPicture()
    }
}

extension ViewController: PresenterOutputProtocol {
    func showLoadedPicture(picture: UIImage) {
        imageView.image = picture
    }
    
    func showError (error: String) {
        print("(ViewController) here we are with error: " + error)
        let alertController = UIAlertController(title: "Ошибка", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

