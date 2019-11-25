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
    let sampleImage = [SampleView(with: "first"),SampleView(with:"second"),SampleView(with:"thrid"),SampleView(with:"last")]
    
    let previewSampleWidth:CGFloat = 100
    let previewSampleMargin:CGFloat = 10
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.delegate = self
        
        view.addSubview(imageView)
        view.addSubview(imagePreView)
        
        imagePreView.backgroundColor = .darkGray

        for sample in sampleImage {
            imagePreView.addSubview(sample)
            sample.translatesAutoresizingMaskIntoConstraints = false
            sample.isUserInteractionEnabled = true
            let tapRecognizer = FilterTapRecognizer(target: self, action: #selector(choosePreview(recognizer:)),filter: sample.getFilterName())
            sample.addGestureRecognizer(tapRecognizer)
        }
        
        //print(sampleImage[0].getName())
        imageView.backgroundColor = .darkGray
        imageView.contentMode = .scaleAspectFit

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
        let factory = FilterFactory()
        guard let image = imageView.image else {
            return
        }
        sampleImage[0].image = factory.image(afterFiltering: image, withIntensity: 1)
        sampleImage[1].image = factory.image(afterFiltering: image, withIntensity: 2)
        sampleImage[2].image = factory.image(afterFiltering: image, withIntensity: 3)
        sampleImage[3].image = factory.image(afterFiltering: image, withIntensity: 4)
    }
    
    private func applySelectedSample(with filterName: String) {
        for sample in sampleImage {
            if(sample.getFilterName() == filterName){
                imageView.image = sample.image
            }
        }
    }
    
    @objc func choosePreview(recognizer: FilterTapRecognizer){
        applySelectedSample(with: recognizer.filterName)
    }
}
