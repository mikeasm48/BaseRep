//
//  ImageViewController.swift
//  HWImageFilter
//
//  Created by Михаил Асмаковец on 25.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UINavigationControllerDelegate {
    
    let imageView = UIImageView()
    let imagePreView = UIView()
    let sampleImage = [UIImageView(),UIImageView(),UIImageView(),UIImageView()]
    
    let previewSampleWidth:CGFloat = 100
    let previewSampleMargin:CGFloat = 10
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.delegate = self
        
        view.addSubview(imageView)
        view.addSubview(imagePreView)
        
        imagePreView.backgroundColor = .darkGray
        imagePreView.addSubview(sampleImage[0])
        imagePreView.addSubview(sampleImage[1])
        imagePreView.addSubview(sampleImage[2])
        imagePreView.addSubview(sampleImage[3])
        
        sampleImage[0].backgroundColor = .red
        sampleImage[1].backgroundColor = .green
        sampleImage[2].backgroundColor = .yellow
        sampleImage[3].backgroundColor = .blue
        
        imageView.backgroundColor = .darkGray
        imageView.contentMode = .scaleAspectFit

        sampleImage[0].translatesAutoresizingMaskIntoConstraints = false
        sampleImage[1].translatesAutoresizingMaskIntoConstraints = false
        sampleImage[2].translatesAutoresizingMaskIntoConstraints = false
        sampleImage[3].translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imagePreView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sampleImage[0].topAnchor.constraint(equalTo: imagePreView.topAnchor, constant: previewSampleMargin),
            sampleImage[0].leftAnchor.constraint(equalTo: imagePreView.leftAnchor,constant: previewSampleMargin),
            sampleImage[0].rightAnchor.constraint(equalTo: imagePreView.leftAnchor, constant: previewSampleWidth),
            sampleImage[0].bottomAnchor.constraint(equalTo: imagePreView.bottomAnchor, constant: -previewSampleMargin),
            //
            sampleImage[1].topAnchor.constraint(equalTo: imagePreView.topAnchor, constant: previewSampleMargin),
            sampleImage[1].leftAnchor.constraint(equalTo: sampleImage[0].rightAnchor),
            sampleImage[1].rightAnchor.constraint(equalTo: sampleImage[0].rightAnchor, constant: previewSampleWidth),
            sampleImage[1].bottomAnchor.constraint(equalTo: imagePreView.bottomAnchor, constant: -previewSampleMargin),
            //
            sampleImage[2].topAnchor.constraint(equalTo: imagePreView.topAnchor, constant: previewSampleMargin),
            sampleImage[2].leftAnchor.constraint(equalTo: sampleImage[1].rightAnchor),
            sampleImage[2].rightAnchor.constraint(equalTo: sampleImage[1].rightAnchor, constant: previewSampleWidth),
            sampleImage[2].bottomAnchor.constraint(equalTo: imagePreView.bottomAnchor, constant: -previewSampleMargin),
            //
            sampleImage[3].topAnchor.constraint(equalTo: imagePreView.topAnchor, constant: previewSampleMargin),
            sampleImage[3].leftAnchor.constraint(equalTo: sampleImage[2].rightAnchor),
            sampleImage[3].rightAnchor.constraint(equalTo: sampleImage[2].rightAnchor, constant: previewSampleWidth),
            sampleImage[3].bottomAnchor.constraint(equalTo: imagePreView.bottomAnchor, constant: -previewSampleMargin),
            imagePreView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imagePreView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imagePreView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imagePreView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            imageView.topAnchor.constraint(equalTo: imagePreView.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        setImagePreviews()
    }
    
    func setImage(image: UIImage) {
        imageView.image = image
    }
    
    func setImagePreviews () {
        var previewIndex = -1
        for _ in sampleImage {
            previewIndex += 1
            sampleImage[previewIndex].image = imageView.image
        }
    }
}
