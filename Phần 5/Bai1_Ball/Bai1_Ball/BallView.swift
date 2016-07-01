//
//  BallView.swift
//  Bai1_Ball
//
//  Created by Truong Nguyen on 6/30/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit
@IBDesignable
class BallView: UIView {
    
    var speedX: CGFloat = 0.1
    var speedY: CGFloat = 0.1
    var speed = 0.0001
    var screenWidth = UIScreen.mainScreen().bounds.width
    var screenHeigh = UIScreen.mainScreen().bounds.height

    @IBInspectable var ballColor: UIColor = UIColor.greenColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        //speed = randomSpeedTime(0.00001, upper: 0.001)
        _ = NSTimer.scheduledTimerWithTimeInterval(speed, target: self, selector: #selector(BallView.updateLocation), userInfo: nil, repeats: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawRect(rect: CGRect) {
//        let path = UIBezierPath(ovalInRect: rect)
//        ballColor.setFill()
//        path.fill()
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, getRandomColor().CGColor)
        CGContextFillEllipseInRect(context, self.bounds)
    }
    
    func getRandomColor() -> UIColor {
        
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    func updateLocation() {
        self.frame.origin.y += self.speedY
        self.frame.origin.x += self.speedX
        if ((self.frame.origin.y + self.frame.size.height) > self.screenHeigh) || (self.frame.origin.y < 0)  {
            self.speedY = (-1)*self.speedY
        }
        if (self.frame.origin.x < 0) || ((self.frame.origin.x + self.frame.size.width) > self.screenWidth) {
            self.speedX = (-1)*self.speedX
        }
    }
}
