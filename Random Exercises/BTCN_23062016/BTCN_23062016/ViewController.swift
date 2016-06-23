//
//  ViewController.swift
//  BTCN_23062016
//
//  Created by Truong Nguyen on 6/23/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayTextField.delegate = self
        monthTextField.delegate = self
        yearTextField.delegate = self
        dayTextField.tag = 0
        
    }
    
    @IBAction func actionCheck(sender: AnyObject) {
        let day = Int(dayTextField.text!)
        let month = Int(monthTextField.text!)
        let year = Int(yearTextField.text!)
        
        let calendar = NSCalendar.currentCalendar()
        let today = NSDate()
        let dateComponents = calendar.components([.Day, .Month, .Year], fromDate: today)
        dateComponents.day = day!
        dateComponents.month = month!
        dateComponents.year = year!
        if let startDate = calendar.dateFromComponents(dateComponents) {
            let startComponents = calendar.components([.Weekday, .Month, .Year], fromDate: startDate)
            let startWeekDay = startComponents.weekday
            var weekDay = ""
            switch startWeekDay {
            case 2:
                weekDay = "Monday"
            case 3:
                weekDay = "Tuesday"
            case 4:
                weekDay = "Wednesday"
            case 5:
                weekDay = "Thusday"
            case 6:
                weekDay = "Friday"
            case 7:
                weekDay = "Sartuday"
            case 1:
                weekDay = "Sunday"
            default:
                break
            }
            displayLabel.text = String(weekDay)
        }
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 0 {
            let dayString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
            if (Int(dayString) > 31) {
                return false
            }
        }
        
        if textField.tag == 1 {
            let monthString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
            if (Int(monthString) > 12) {
                return false
            }
        }
        return true
    }
}
