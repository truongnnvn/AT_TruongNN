//
//  MyView.swift
//  Bai5_
//
//  Created by Truong Nguyen on 6/30/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit
class MyView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet var pencilOutlet: [UIButton]!

    var lastPoint = CGPoint.zero
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    var currentLocation = CGPoint(x: 0, y: 0)
    var lastLocation = CGPoint(x: 0, y: 0)
    
    var touchOld: UITouch! = nil
    var touch: UITouch! = nil
    var percent:CGFloat!
    var isSelected = true
    
    let colors: [(CGFloat, CGFloat, CGFloat)] = [
        (0, 0, 0),
        (105.0 / 255.0, 105.0 / 255.0, 105.0 / 255.0),
        (1.0, 0, 0),
        (0, 0, 1.0),
        (51.0 / 255.0, 204.0 / 255.0, 1.0),
        (102.0 / 255.0, 204.0 / 255.0, 0),
        (102.0 / 255.0, 1.0, 0),
        (160.0 / 255.0, 82.0 / 255.0, 45.0 / 255.0),
        (1.0, 102.0 / 255.0, 0),
        (1.0, 1.0, 0),
        (1.0, 1.0, 1.0),
        ]
    
    @IBAction func selectedPencil(sender: AnyObject) {
        var index = sender.tag ?? 0
        if index < 0 || index >= colors.count {
            index = 0
        }
        
        (red, green, blue) = colors[index]
        if index == colors.count - 1 {
            opacity = 1.0
        }
        let tag = sender.tag
        if isSelected {
            if tag == 0 {
                pencilOutlet[0].center.y -= 10
            } else if tag == 1 {
                pencilOutlet[1].center.y -= 10
            } else if tag == 2 {
                pencilOutlet[2].center.y -= 10
            } else if tag == 3 {
                pencilOutlet[3].center.y -= 10
            } else if tag == 4 {
                pencilOutlet[4].center.y -= 10
            } else if tag == 5 {
                pencilOutlet[5].center.y -= 10
            } else if tag == 6 {
                pencilOutlet[6].center.y -= 10
            } else if tag == 7 {
                pencilOutlet[7].center.y -= 10
            } else if tag == 8 {
                pencilOutlet[8].center.y -= 10
            } else if tag == 9 {
                pencilOutlet[9].center.y -= 10
            } else if tag == 10 {
                pencilOutlet[10].center.y -= 10
            }
            isSelected = false
        } else {
            if tag == 0 {
                pencilOutlet[0].center.y += 10
            } else if tag == 1 {
                pencilOutlet[1].center.y += 10
            } else if tag == 2 {
                pencilOutlet[2].center.y += 10
            } else if tag == 3 {
                pencilOutlet[3].center.y += 10
            } else if tag == 4 {
                pencilOutlet[4].center.y += 10
            } else if tag == 5 {
                pencilOutlet[5].center.y += 10
            } else if tag == 6 {
                pencilOutlet[6].center.y += 10
            } else if tag == 7 {
                pencilOutlet[7].center.y += 10
            } else if tag == 8 {
                pencilOutlet[8].center.y += 10
            } else if tag == 9 {
                pencilOutlet[9].center.y += 10
            } else if tag == 10 {
                pencilOutlet[10].center.y += 10
            }
            isSelected = true
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.locationInView(self)
        }
//        let duration: NSTimeInterval = 1.0
//        UIView.animateWithDuration(duration, animations: { () -> Void in
//            self.blackButton.frame = CGRectMake(
//                self.blackButton.frame.origin.x,
//                self.blackButton.frame.origin.y - 100,
//                self.blackButton.frame.size.width,
//                self.blackButton.frame.size.height)
//        })
//         self.blackButton.frame.origin.y -= 10
    }

    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        
        // 1
        UIGraphicsBeginImageContext(self.frame.size)
        let context = UIGraphicsGetCurrentContext()
        tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        
        // 2
        CGContextMoveToPoint(context, fromPoint.x, fromPoint.y)
        CGContextAddLineToPoint(context, toPoint.x, toPoint.y)
        
        // 3
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetLineWidth(context, brushWidth)
        CGContextSetRGBStrokeColor(context, red, green, blue, 1.0)
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        // 4
        CGContextStrokePath(context)
        
        // 5
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // 6
        swiped = true
        if let touch = touches.first {
            let currentPoint = touch.locationInView(self)
            drawLineFrom(lastPoint, toPoint: currentPoint)
            
        // 7
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if !swiped {
            // draw a single point
            drawLineFrom(lastPoint, toPoint: lastPoint)
        }
        
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
        tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), blendMode: CGBlendMode.Normal, alpha: opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempImageView.image = nil
    }
}
