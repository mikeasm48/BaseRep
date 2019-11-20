//
//  FullSizeImageViewController.swift
//  HWCoreData
//
//  Created by Михаил Асмаковец on 20.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UINavigationControllerDelegate {

    let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        imageView.backgroundColor = .darkGray
        return imageView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor.cyan
        navigationController?.delegate = self
        imageView.frame = self.view.frame
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
    }

    func setImage(image: UIImage) {
        imageView.image = image
    }
}
