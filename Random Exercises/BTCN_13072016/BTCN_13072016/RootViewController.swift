//
//  RootViewController.swift
//  BTCN_13072016
//
//  Created by Truong Nguyen on 7/14/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    @IBOutlet weak var resultTextfield: UITextField!
    @IBOutlet weak var myDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func okButton(sender: AnyObject) {
        self.resultTextfield.text = timeAgo(myDatePicker.date)
    }
    
    func timeAgo(date:NSDate) -> String {
        let calendar = NSCalendar.currentCalendar()
        let now = NSDate()
        let earliest = now.earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:NSDateComponents = calendar.components([NSCalendarUnit.Second, NSCalendarUnit.Minute , NSCalendarUnit.Hour , NSCalendarUnit.Day , NSCalendarUnit.WeekOfYear , NSCalendarUnit.Month , NSCalendarUnit.Year], fromDate: earliest, toDate: latest, options: NSCalendarOptions())
        
        if (components.year >= 1) {
            if components.month == 0 {
                return "\(components.year) years ago"
            } else {
                return "\(components.year) years \(components.month) months ago"
            }
        } else if (components.month >= 1) {
            if components.weekOfYear == 0 {
                return "\(components.month) months ago"
            } else {
                return "\(components.month) months \(components.weekOfYear) weeks ago"
            }
        } else if (components.weekOfYear >= 1) {
            if components.day == 0 {
                return "\(components.weekOfYear) weeks ago"
            } else {
                return "\(components.weekOfYear) weeks \(components.day) days ago"
            }
        } else if (components.day >= 1) {
            if components.hour == 0 {
                return "\(components.day) days ago"
            } else {
                return "\(components.day) days \(components.hour) hours ago"
            }
        } else if (components.hour >= 1) {
            if components.minute == 0 {
                return "\(components.hour) hours ago"
            } else {
                return "\(components.hour) hours \(components.minute) minutes ago"
            }
        } else if (components.minute >= 1) {
            return "\(components.minute) minutes ago"
        } else if (components.second >= 1) {
            return "\(components.second) seconds ago"
        } else {
            return "Just now"
        }
    }
}
