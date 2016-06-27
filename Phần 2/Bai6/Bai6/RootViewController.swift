//
//  RootViewController.swift
//  Bai6
//
//  Created by Truong Nguyen on 6/24/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var moveView: UIView!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var lblPercent: UILabel!
    
    var currentLocation = CGPoint(x: 0, y: 0)
    var lastLocation = CGPoint(x: 0, y: 0)
    
    var touchOld: UITouch! = nil
    var touch: UITouch! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblPercent.text = "50%"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touch == nil {
            touch = touches.first! as UITouch
            currentLocation = touch.locationInView(self.view)
            
            touchOld = touch
            lastLocation = touchOld.locationInView(self.view)
            
        } else {
            touch = touches.first! as UITouch
            currentLocation = touch.locationInView(self.view)
            if touch.view == sliderView {
                if touch != touchOld {
                    touchOld = touch
                    lastLocation = touchOld.locationInView(self.view)
                    self.move()
                } else {
                    self.move()
                }
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
                var percent = (heightMoveView/heightBackgroundView)*100
                
                if percent > 100 {
                    
                    self.sliderView.center.y = 0
                    self.moveView.frame.size.height = self.backgroundView.frame.size.height
                    self.moveView.frame.origin.y = 0
                    percent = 100
                    self.lblPercent.text = "\(Int(percent))%"
                    lastLocation = currentLocation
                    return
                    
                } else if currentLocation.y > self.backgroundView.frame.origin.y + self.backgroundView.frame.size.height {
                    
                    self.sliderView.center.y = bottomSilderBar
                    self.moveView.frame.size.height = 0
                    self.moveView.frame.origin.y = self.backgroundView.frame.size.height
                    percent = 0
                    self.lblPercent.text = "\(Int(percent))%"
                    lastLocation = currentLocation
                    return
                    
                } else {
                    
                    self.lblPercent.text = "\(Int(percent))%"
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
