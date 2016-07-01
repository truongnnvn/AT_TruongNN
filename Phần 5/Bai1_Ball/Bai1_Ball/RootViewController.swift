//
//  RootViewController.swift
//  Bai1_Ball
//
//  Created by Truong Nguyen on 6/30/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Drawing"
        let ball = BallView(frame: CGRectMake(100,100,100,100))
        self.view.addSubview(ball)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.createBall()
    }
    
    func createBall() {
        let frameScreen = UIScreen.mainScreen().bounds
        let x = CGFloat(Int(arc4random())%Int(frameScreen.width))
        let y = CGFloat(Int(arc4random())%Int(frameScreen.height))
        let wid = CGFloat(Int(arc4random())%Int(frameScreen.width))
        let frameBall = CGRectMake(x, y, wid, wid)
        let ball = BallView(frame: frameBall)
        let randomSpeed = randomBetweenNumbers(0.0009, secondNum: 0.001)
        let randomX = randomBetweenNumbers(-1, secondNum: 1)
        let randomY = randomBetweenNumbers(-1, secondNum: 1)
        ball.speed = Double(randomSpeed)
        ball.speedX = randomX
        ball.speedY = randomY
        self.view.addSubview(ball)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }

}

