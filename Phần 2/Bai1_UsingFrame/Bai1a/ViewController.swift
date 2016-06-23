//
//  ViewController.swift
//  Bai1a
//
//  Created by Truong Nguyen on 6/23/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var inputTF: UITextField!
    @IBOutlet weak var displayLabel: UILabel!
    
    var isPresentKeyboard = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.hidden = true
        inputTF.delegate = self
        inputTF.returnKeyType = .Done
        inputTF.clearButtonMode = .WhileEditing
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: self.view.window)
    }
    
    func keyboardWillHide(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        if ((self.view.frame.height - (self.inputTF.frame.origin.y + self.inputTF.frame.height)) < keyboardSize.height) {
            self.view.frame.origin.y += keyboardSize.height
        }
    }
    
    func keyboardWillShow(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        let offset: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size
        if ((self.view.frame.height - (self.inputTF.frame.origin.y + self.inputTF.frame.height)) < keyboardSize.height) {
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
        inputTF.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        inputTF.resignFirstResponder()
        okButton(UIButton)
        return true
    }
    
    @IBAction func okButton(sender: AnyObject) {
        displayLabel.hidden = false
        if inputTF.text == "" {
            displayLabel.text = "Please input data"
        } else {
            displayLabel.text = inputTF.text
        }
    }
}
