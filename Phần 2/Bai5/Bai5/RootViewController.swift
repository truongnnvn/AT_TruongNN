//
//  RootViewController.swift
//  Bai5
//
//  Created by Truong Nguyen on 6/24/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    @IBOutlet weak var myView: UIView!
    var lastLocation = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            self.lastLocation = touch.locationInView(self.view)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            if touch.view == myView {
                let location = touch.locationInView(self.view)
                self.myView.center = CGPoint(x: (location.x - self.lastLocation.x) + self.myView.center.x, y: (location.y - self.lastLocation.y) + self.myView.center.y)
                lastLocation = touch.locationInView(self.view)
            } else {
                print("Its not view")
            }
        }
    }
}
