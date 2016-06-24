//
//  RootViewController.swift
//  Bai4
//
//  Created by Truong Nguyen on 6/24/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    var isPaused = false
    var isTimer:NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if isPaused == false {
            isTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(RootViewController.count), userInfo: nil, repeats: true)
            isPaused = true
        } else {
            isTimer?.invalidate()
            isPaused = false
        }
    }

    func count() {
        let currentDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let timer = dateFormatter.stringFromDate(currentDate)
        displayLabel.text = timer
    }
}
