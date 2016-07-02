//
//  RootViewController.swift
//  Bai6_TapGesture
//
//  Created by Truong Nguyen on 7/1/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    var swipeRecognizer: UISwipeGestureRecognizer!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(RootViewController.handleSwipes(_:)))
    }
    
    func handleSwipes(sender: UISwipeGestureRecognizer){
        if sender.direction == .Down {
            print("Swiped Down")
        }
        if sender.direction == .Left {
            print("Swiped Left")
        }
        if sender.direction == .Right {
            print("Swiped Right")
        }
        if sender.direction == .Up {
            print("Swiped Up")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeRecognizer.numberOfTouchesRequired = 1
        view.addGestureRecognizer(swipeRecognizer)
    }
}
