//
//  Ball.swift
//  ball
//
//  Created by Truong Nguyen on 6/29/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit
@IBDesignable
class Ball: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
    
    func getRandomColor() -> UIColor {
        
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    override func drawRect(rect: CGRect) {
//        let path = UIBezierPath(ovalInRect: rect)
//        UIColor.greenColor().setFill()
//        path.fill()
//        let context = UIGraphicsGetCurrentContext()
//        CGContextSetFillColorWithColor(context, getRandomColor().CGColor)
//        CGContextFillEllipseInRect(context, self.bounds)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 20.0)
        CGContextSetStrokeColorWithColor(context,
                                         UIColor.blueColor().CGColor)
        let dashArray:[CGFloat] = [2,6,4,2]
        CGContextSetLineDash(context, 3, dashArray, 4)
        CGContextMoveToPoint(context, 10, 200)
        CGContextAddQuadCurveToPoint(context, 150, 10, 300, 200)
        CGContextStrokePath(context)
    }
}
