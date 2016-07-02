//
//  MyView.swift
//  Bai3_Clock
//
//  Created by Truong Nguyen on 7/1/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class MyView: UIView {
    
    override func drawRect(rect:CGRect) {
            
        // obtain context
        let ctx = UIGraphicsGetCurrentContext()
        
        // decide on radius
        let rad = CGRectGetWidth(rect)/3.5
        
        let endAngle = CGFloat(2*M_PI)
        
        // add the circle to the context
        CGContextAddArc(ctx, CGRectGetMidX(rect), CGRectGetMidY(rect), rad, 0, endAngle, 1)
        
        // set fill color
        CGContextSetFillColorWithColor(ctx,UIColor.grayColor().CGColor)
        
        // set stroke color
        CGContextSetStrokeColorWithColor(ctx,UIColor.whiteColor().CGColor)
        
        // set line width
        CGContextSetLineWidth(ctx, 4.0)
        // use to fill and stroke path (see http://stackoverflow.com/questions/13526046/cant-stroke-path-after-filling-it )
        
        // draw the path
        CGContextDrawPath(ctx, CGPathDrawingMode.Stroke);
        
        secondMarkers(ctx!, x: CGRectGetMidX(rect), y: CGRectGetMidY(rect), radius: rad, sides: 60, color: UIColor.whiteColor())
        
        drawText(rect, ctx: ctx!, x: CGRectGetMidX(rect), y: CGRectGetMidY(rect), radius: rad, sides: .twelve, color: UIColor.whiteColor())
    }
}
