//
//  ViewController.swift
//  BTCN_22062016
//
//  Created by Truong Nguyen on 6/22/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var displayLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.delegate = self
        displayLabel.hidden = true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        let numOfCharacters = newString.characters.count
        displayLabel.hidden = false
        if numOfCharacters <= 126 {
            if numOfCharacters == 0 {
                displayLabel.hidden = true
            }
            displayLabel.text = "\(numOfCharacters)"
            return true
        }
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

