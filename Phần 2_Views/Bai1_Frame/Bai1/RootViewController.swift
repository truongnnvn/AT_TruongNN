//
//  RootViewController.swift
//  Bai1
//
//  Created by Truong Nguyen on 7/2/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func okButton(sender: AnyObject) {
        self.displayLabel.hidden = false
        if self.myTextField.text == "" {
            self.displayLabel.text = "Please input data"
        } else {
            self.displayLabel.text = self.myTextField.text
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        myTextField.resignFirstResponder()
        self.MoveScreenWhenHideKeyboard()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        myTextField.endEditing(true)
        MoveScreenWhenHideKeyboard()
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        MoveScreenWhenShowKeyboard()
        return true
    }
    
    func MoveScreenWhenShowKeyboard() {
        var screenFrame = self.view.frame
        if screenFrame.origin.y < 0 {
            return
        }
        screenFrame.origin.y -= 100
        UIView.animateWithDuration(0.5, animations: {
            self.view.frame = screenFrame
            })
    }
    
    func MoveScreenWhenHideKeyboard() {
        var screenFrame = self.view.frame
        if screenFrame.origin.y >= 0 {
            return
        }
        screenFrame.origin.y += 100
        UIView.animateWithDuration(0.5, animations: {
            self.view.frame = screenFrame
        })
    }
}
