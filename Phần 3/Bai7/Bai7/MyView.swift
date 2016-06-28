//
//  MyView.swift
//  Bai7
//
//  Created by Truong Nguyen on 6/28/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit
protocol myViewDelegate {
    func sentData(myView: MyView, percent: CGFloat)
}
class MyView: UIView {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var moveView: UIView!
    @IBOutlet weak var sliderView: UIView!
    
    @IBOutlet weak var percentLabel: UILabel!
    var currentLocation = CGPoint(x: 0, y: 0)
    var lastLocation = CGPoint(x: 0, y: 0)
    
    var touchOld: UITouch! = nil
    var touch: UITouch! = nil
    var percent:CGFloat!

    var delegate:myViewDelegate!

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touch == nil {
            touch = touches.first! as UITouch
            currentLocation = touch.locationInView(self)
            
            touchOld = touch
            lastLocation = touchOld.locationInView(self)
            
        } else {
            touch = touches.first! as UITouch
            currentLocation = touch.locationInView(self)
            if touch.view == sliderView {
                if touch != touchOld {
                    touchOld = touch
                    lastLocation = touchOld.locationInView(self)
                    self.move()
                } else {
                    self.move()
                }
            }
        }
    }
    
    internal func setPercentNumber(percent: String) {
        
        var percentNumber = percent
        
        if percentNumber.characters.last == "%" {
            percentNumber = percentNumber.substringToIndex(percentNumber.endIndex.predecessor())
        }
        
        if let rightPercent = Float(percentNumber) {
            var sliderViewCenter = self.sliderView.center
            var moveViewFrame = self.moveView.frame
            
            if rightPercent >= 0 && rightPercent <= 100 {
                sliderViewCenter.y = 300 - 3*CGFloat(rightPercent)
                moveViewFrame.size.height = 3*CGFloat(rightPercent)
                moveViewFrame.origin.y = sliderViewCenter.y
                UIView.animateWithDuration(1, animations: {
                    self.moveView.frame = moveViewFrame
                    self.sliderView.center = sliderViewCenter
                    }, completion: { (complete) in
                        self.percentLabel.text = String(rightPercent)
                })
            }
        }
    }
    
    func move() {
        let distanceMoved = currentLocation.y - lastLocation.y
        let sliderViewCenter = self.sliderView.center.y
        let bottomSilderBar = self.backgroundView.frame.size.height

        if !(sliderViewCenter < 0 || sliderViewCenter > bottomSilderBar) {
            
            self.sliderView.center.y = sliderViewCenter + distanceMoved
            self.moveView.frame.origin.y = sliderViewCenter + distanceMoved
            self.moveView.frame.size.height -= distanceMoved
            let heightMoveView = self.moveView.frame.size.height
            let heightBackgroundView = self.backgroundView.frame.size.height
            percent = (heightMoveView/heightBackgroundView)*100
            if let delegate = self.delegate {
                delegate.sentData(self, percent: percent)
            }
            if percent > 100 {
                
                self.sliderView.center.y = 0
                self.moveView.frame.size.height = self.backgroundView.frame.size.height
                self.moveView.frame.origin.y = 0
                percent = 100
                self.percentLabel.text = "\(Int(percent))%"
                lastLocation = currentLocation
                return
                
            } else if currentLocation.y > self.backgroundView.frame.origin.y + self.backgroundView.frame.size.height {
                
                self.sliderView.center.y = bottomSilderBar
                self.moveView.frame.size.height = 0
                self.moveView.frame.origin.y = self.backgroundView.frame.size.height
                percent = 0
                self.percentLabel.text = "\(Int(percent))%"
                lastLocation = currentLocation
                return
                
            } else {
                
                self.percentLabel.text = "\(Int(percent))%"
                lastLocation = currentLocation
                return
                
            }
        } else {
            
            if sliderViewCenter > bottomSilderBar {
                self.sliderView.center.y = bottomSilderBar
                self.moveView.frame.size.height = 0
                self.moveView.frame.origin.y = self.backgroundView.frame.size.height
                lastLocation = currentLocation
                return
            }
        }
    }
}
