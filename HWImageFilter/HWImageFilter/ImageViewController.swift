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
    let sampleImages = [SampleView(with: "noFilter"),SampleView(with:"SepiaTone"),SampleView(with:"SharpenLuminance"),SampleView(with:"GaussianBlur")]
    
    let previewSampleWidth:CGFloat = 100
    let previewSampleMargin:CGFloat = 10
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.delegate = self
        
        view.addSubview(imageView)
        view.addSubview(imagePreView)
        
        imagePreView.backgroundColor = .darkGray

        for sample in sampleImages {
            imagePreView.addSubview(sample)
            sample.translatesAutoresizingMaskIntoConstraints = false
            sample.isUserInteractionEnabled = true
            let tapRecognizer = FilterTapRecognizer(target: self, action: #selector(choosePreview(recognizer:)),filter: sample.getFilterName())
            sample.addGestureRecognizer(tapRecognizer)
        }
        
        imageView.backgroundColor = .darkGray
        imageView.contentMode = .scaleAspectFit

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imagePreView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sampleImages[0].topAnchor.constraint(equalTo: imagePreView.topAnchor, constant: previewSampleMargin),
            sampleImages[0].leftAnchor.constraint(equalTo: imagePreView.leftAnchor,constant: previewSampleMargin),
            sampleImages[0].rightAnchor.constraint(equalTo: imagePreView.leftAnchor, constant: previewSampleWidth),
            sampleImages[0].bottomAnchor.constraint(equalTo: imagePreView.bottomAnchor, constant: -previewSampleMargin),
            //
            sampleImages[1].topAnchor.constraint(equalTo: imagePreView.topAnchor, constant: previewSampleMargin),
            sampleImages[1].leftAnchor.constraint(equalTo: sampleImages[0].rightAnchor),
            sampleImages[1].rightAnchor.constraint(equalTo: sampleImages[0].rightAnchor, constant: previewSampleWidth),
            sampleImages[1].bottomAnchor.constraint(equalTo: imagePreView.bottomAnchor, constant: -previewSampleMargin),
            //
            sampleImages[2].topAnchor.constraint(equalTo: imagePreView.topAnchor, constant: previewSampleMargin),
            sampleImages[2].leftAnchor.constraint(equalTo: sampleImages[1].rightAnchor),
            sampleImages[2].rightAnchor.constraint(equalTo: sampleImages[1].rightAnchor, constant: previewSampleWidth),
            sampleImages[2].bottomAnchor.constraint(equalTo: imagePreView.bottomAnchor, constant: -previewSampleMargin),
            //
            sampleImages[3].topAnchor.constraint(equalTo: imagePreView.topAnchor, constant: previewSampleMargin),
            sampleImages[3].leftAnchor.constraint(equalTo: sampleImages[2].rightAnchor),
            sampleImages[3].rightAnchor.constraint(equalTo: sampleImages[2].rightAnchor, constant: previewSampleWidth),
            sampleImages[3].bottomAnchor.constraint(equalTo: imagePreView.bottomAnchor, constant: -previewSampleMargin),
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
        
        
        for sample in sampleImages {
            sample.image = image
        }
        sampleImages[0].filteredImage = image
        
        let group = DispatchGroup()
        
        DispatchQueue.main.async {
            group.enter()
            self.sampleImages[1].filteredImage = factory.sepiaTone(image, withIntensity: 5)
            group.leave()
        }
        
        DispatchQueue.main.async {
            group.enter()
            self.sampleImages[2].filteredImage = factory.sharpenLuminance(image, inputRadius: 5, inputSharpness: 5)
            group.leave()
        }
        
        DispatchQueue.main.async {
            group.enter()
            self.sampleImages[3].filteredImage = factory.gaussianBlur(image, inputRadius: 2)
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            for sample in self.sampleImages {
                guard let filteredImage = sample.filteredImage else {
                    return
                }
                sample.image = filteredImage
            }
        }
    }
    
    private func applySelectedSample(with filterName: String) {
        for sample in sampleImages {
            if(sample.getFilterName() == filterName){
                imageView.image = sample.image
            }
        }
    }
    
    @objc func choosePreview(recognizer: FilterTapRecognizer){
        applySelectedSample(with: recognizer.filterName)
    }
}
