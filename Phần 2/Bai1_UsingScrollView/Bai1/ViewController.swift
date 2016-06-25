//
//  ViewController.swift
//  Bai1
//
//  Created by Truong Nguyen on 6/23/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var okButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayLabel.hidden = true
        self.inputTextField.delegate = self
        self.inputTextField.returnKeyType = .Done
        self.inputTextField.clearButtonMode = .WhileEditing
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.hideKeyboard))
        // prevents the scroll view from swallowing up the touch event of child buttons
        tapGesture.cancelsTouchesInView = false
        myScrollView.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.registerForKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func okButton(sender: AnyObject) {
        self.displayLabel.hidden = false
        if self.inputTextField.text == "" {
            self.displayLabel.text = "Please input data"
        } else {
            self.displayLabel.text = self.inputTextField.text
        }
        self.myScrollView.setContentOffset(CGPointZero, animated: true)
    }
   
    //MARK: Keyboard Avoidance
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.inputTextField.resignFirstResponder()
        self.okButton(UIButton)
        return true
    }
    
    func registerForKeyboardNotifications() -> Void {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWasShown(_:)), name: UIKeyboardDidShowNotification, object: nil)
    }
    
    func deregisterFromKeyboardNotifications() -> Void {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWasShown(_:)), name: UIKeyboardDidHideNotification, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification) {
        var info: Dictionary = notification.userInfo!
        let keyboardSize: CGSize = (info[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue().size)!
        let buttonOrigin: CGPoint = self.okButton.frame.origin
        let buttonHeight: CGFloat = self.okButton.frame.size.height
        var visibleRect: CGRect = self.view.frame
        visibleRect.size.height -= keyboardSize.height
        
        if (!CGRectContainsPoint(visibleRect, buttonOrigin)) {
            let scrollPoint: CGPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight)
            self.myScrollView.setContentOffset(scrollPoint, animated: true)
        }
    }

    func hideKeyboard() {
        self.inputTextField.resignFirstResponder()
        self.myScrollView.setContentOffset(CGPointZero, animated: true)
    }
}
