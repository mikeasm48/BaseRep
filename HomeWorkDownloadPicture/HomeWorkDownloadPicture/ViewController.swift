//
//  ViewController.swift
//  HomeWorkDownloadPicture
//
//  Created by Михаил Асмаковец on 28.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageView = UIImageView ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenWidth = view.frame.size.width
        imageView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth)
        imageView.image = UIImage(named: "DefaultPicture")
        imageView.contentMode = .scaleAspectFill
        view.backgroundColor = .white
        view.addSubview(imageView)
    }
}

