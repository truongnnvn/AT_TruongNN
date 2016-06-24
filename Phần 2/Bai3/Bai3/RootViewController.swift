//
//  RootViewController.swift
//  Bai3
//
//  Created by Truong Nguyen on 6/24/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var displayLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let currentDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss , EEE, dd MMM yyyy "
        let timer = dateFormatter.stringFromDate(currentDate)
        displayLabel.text = timer
    }
}
