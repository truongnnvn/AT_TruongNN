//
//  RootViewController.swift
//  Bai2
//
//  Created by Truong Nguyen on 6/27/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Custom View"
        let myView = MyView(frame: CGRectMake(120, 100, 100, 125))
        myView.avatarImageView.image = UIImage(named: "money")
        myView.nameLabel.text = "Nhat Truong"
        self.view.addSubview(myView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
