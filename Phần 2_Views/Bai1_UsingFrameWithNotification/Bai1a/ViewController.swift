//
//  ViewController.swift
//  Bai1a
//
//  Created by Truong Nguyen on 6/23/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayLabel.hidden = true
        self.inputTextField.delegate = self
        self.inputTextField.returnKeyType = .Done
        self.inputTextField.clearButtonMode = .WhileEditing
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: self.view.window)
    }
    
    func keyboardWillHide(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        if ((self.view.frame.height - (self.inputTextField.frame.origin.y + self.inputTextField.frame.height)) < keyboardSize.height) {
            self.view.frame.origin.y += keyboardSize.height
        }
    }
    
    func keyboardWillShow(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        let offset: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size
        if ((self.view.frame.height - (self.inputTextField.frame.origin.y + self.inputTextField.frame.height)) < keyboardSize.height) {
            if keyboardSize.height == offset.height {
                if self.view.frame.origin.y == 0 {
                    UIView.animateWithDuration(0.1, animations: { () -> Void in
                        self.view.frame.origin.y -= keyboardSize.height
                    })
                }
            } else {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.view.frame.origin.y += keyboardSize.height - offset.height
                })
            }
        }
    }
    
    
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.inputTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.inputTextField.resignFirstResponder()
        self.okButton(UIButton)
        return true
    }
    
    @IBAction func okButton(sender: AnyObject) {
        self.displayLabel.hidden = false
        if self.inputTextField.text == "" {
            self.displayLabel.text = "Please input data"
        } else {
            self.displayLabel.text = self.inputTextField.text
        }
    }
}
