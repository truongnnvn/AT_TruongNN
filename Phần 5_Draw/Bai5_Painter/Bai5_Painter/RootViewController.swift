//
//  RootViewController.swift
//  Bai5_
//
//  Created by Truong Nguyen on 6/30/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeigh = UIScreen.mainScreen().bounds.height
        let frame = CGRectMake(0, 0, screenWidth, screenHeigh)
        let myView = NSBundle.mainBundle().loadNibNamed("MyView", owner: nil, options: nil).last as! MyView
        myView.frame = frame
        self.view.addSubview(myView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
