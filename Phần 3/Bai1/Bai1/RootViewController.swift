//
//  RootViewController.swift
//  Bai1
//
//  Created by Truong Nguyen on 6/27/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Custom View"
        let myView = MyView(frame: CGRectMake(100, 100, 100, 125))
        self.view.addSubview(myView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
