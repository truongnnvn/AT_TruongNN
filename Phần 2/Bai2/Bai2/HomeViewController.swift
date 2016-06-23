//
//  HomeViewController.swift
//  Bai2
//
//  Created by Truong Nguyen on 6/23/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameLabel.text = self.username
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
