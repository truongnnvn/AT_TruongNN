//
//  RootViewController.swift
//  ball
//
//  Created by Truong Nguyen on 6/29/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Drawing"
    }
    
    func createBall() {
        let frameScreen = UIScreen.mainScreen().bounds
        let x = CGFloat(Int(arc4random())%Int(frameScreen.width))
        let y = CGFloat(Int(arc4random())%Int(frameScreen.height))
        let wid = CGFloat(Int(arc4random())%Int(frameScreen.width))
        let frame = CGRectMake(x, y, wid, wid)
        let ball = Ball(frame: frame)
        self.view.addSubview(ball)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //for var i in 0...9 {
            self.createBall()
          //  i += 1
        //}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
