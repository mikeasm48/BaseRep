//
//  ViewController.swift
//  HomeWorkSwiftAnimation
//
//  Created by Михаил Асмаковец on 17.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    
    var interrupted: Bool = false
    
    //Кнопка для анимации
    let button : UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Group Animation", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action:  #selector(tapButton), for:.touchDown)
        button.frame = CGRect(x: 25.0, y:150.0, width: 200.0, height: 40.0)
        return button
    }()
    
    //Кнопка: начало анимации
    let buttonStart : UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Start", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action:  #selector(tapButtonStart), for:.touchDown)
        button.frame = CGRect(x: 25.0, y: 200.0, width: 200.0, height: 40.0)
        return button
    }()
    
    //Кнопка: остановка анимации
    let buttonStop : UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Stop", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action:  #selector(tapButtonStop), for:.touchDown)
        button.frame = CGRect(x: 25.0, y: 250.0, width: 200.0, height: 40.0)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
        view.addSubview(button)
        view.addSubview(buttonStart)
        view.addSubview(buttonStop)
    }
    
    //Нажатие кнопки с анимацией
    @objc func tapButton() {
       print("Ничего не делаем")
    }
    
    //Нажатие кнопк старта анимации
    @objc func tapButtonStart () {
        stopButtonAnimation()
        doGroupAnimations()
    }
    
    //Нажате кнопрки остановки анимации
    @objc func tapButtonStop () {
        stopButtonAnimation()
        //button.setTitle("Animations прервана", for: .normal)
    }

    //Групповая анимация
    @objc func doGroupAnimations() {
        print("Выполняем doGroupAnimation")
        interrupted = false
        button.setTitle("Animations started", for: .normal)
        //CABasicAnimation: transform.scale.x
        let animationBasicBackScale = CABasicAnimation(keyPath: "transform.scale.x")
        animationBasicBackScale.fromValue = 1
        animationBasicBackScale.toValue = 2
        animationBasicBackScale.duration = 1.0
        
        //CABasicAnimation: backgroundColor
        let animationBasicBackColor = CABasicAnimation(keyPath: "backgroundColor")
        animationBasicBackColor.fromValue = UIColor.red.cgColor
        animationBasicBackColor.toValue = UIColor.green.cgColor
        animationBasicBackColor.duration = 3.0
        
        //CABasicAnimation: opacity
        let animationBasicOpacity = CABasicAnimation(keyPath: "opacity")
        animationBasicOpacity.fromValue = 1.0
        animationBasicOpacity.toValue = 0.0
        animationBasicOpacity.duration = 3.0
        animationBasicOpacity.autoreverses = false
        animationBasicOpacity.repeatCount = 2

        //CABasicAnimation: position
        let animationBasicPosition = CABasicAnimation(keyPath: "position")
        animationBasicPosition.toValue = [100,100]
        animationBasicPosition.duration = 3.0
        
        //CAKeyframeAnimation: position
        let keyFramePosition = CAKeyframeAnimation(keyPath: "position")
        
        let pathArray = [[200,10],[10,200],[300,100],[300,300]]
        
        keyFramePosition.values = pathArray
        keyFramePosition.duration = 3.0
        //TODO не работает
        //keyFramePosition.delegate = self
        
        //CASpringAnimation
        let springAnimation = CASpringAnimation(keyPath: "transform.scale")
        
        springAnimation.fromValue = 0
        springAnimation.toValue = 1
        
        springAnimation.duration = 2.0
        
        
        //Group Animation
        let groupAnimation = CAAnimationGroup()
        
        groupAnimation.animations = [springAnimation, keyFramePosition,animationBasicBackScale,animationBasicBackColor, animationBasicOpacity, animationBasicPosition]
        
        var preAnimation: CAAnimation = CAAnimation()
 
        for animation in groupAnimation.animations! {
            animation.beginTime = preAnimation.beginTime + preAnimation.duration
            preAnimation = animation
            //TODO не работает
            //animation.delegate = self
        }
        
        groupAnimation.duration = groupAnimation.animations!.last!.beginTime + groupAnimation.animations!.last!.duration
        
        groupAnimation.delegate = self
        
        button.layer.add(groupAnimation, forKey: "animationGroup")
    }
    
    //Остановка анимации
    @objc func stopButtonAnimation() {
        print("Выполняем removeAllAnimations")
        button.layer.removeAllAnimations()
        interrupted = true
    }
    
    func animationDidStart(_ anim: CAAnimation) {
        button.setTitle("\(type(of:anim))", for: .normal)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if interrupted {
            button.setTitle("Анимация прервана", for: .normal)
        }else{
            button.setTitle("Анимация завершена", for: .normal)
        }
    }
}

