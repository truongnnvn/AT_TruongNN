//
//  Common.swift
//  AT-NNTApp
//
//  Created by Truong Nguyen on 7/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import Foundation
import UIKit

class Common {
//    func validateTextField(username: String, password: String, email: String) -> Bool {
//        if username == "" || password == "" || email == "" {
//            alertWithOkButton("Message", message: "Username or Password or Email is required")
//        } else {
//            if password.characters.count >= 6 && password.characters.count <= 20 {
////                if validateEmail(email) {
////                    return true
////                } else {
////                    alertWithOkButton("Message", message: "Invalid email, please try again")
////                }
//            } else {
//                alertWithOkButton("Message", message: "Password must be greater than 6 and less than 20 characters")
//            }
//        }
//        return false
//    }
}

enum ValidateType: String {
    case Email = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
}

extension String {
    func validate(type: ValidateType) -> Bool {
        let emailTest = NSPredicate(format:"SELF MATCHES %@", type.rawValue)
        return emailTest.evaluateWithObject(self)
    }
}

extension UIViewController
{
    func hideKeyboardWhenTappedAround()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

extension UIImageView {
    func CircleImage() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
    func BorderImage() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.cornerRadius = 7
        self.clipsToBounds = true
    }

    
    func blurImage()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }

}

