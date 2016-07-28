//
//  BaseViewController.swift
//  AT_TruongNN_Realm_Student
//
//  Created by Truong Nguyen on 7/27/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit
import RealmSwift
class BaseViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configurationUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func loadData() {

    }

    func configurationUI() {
        // Navigation
        self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.translucent = true
    }

    func validateLoginFlow(email: String, password: String) -> Bool {
        if email == "" || password == "" {
            alertWithOkButton(Strings.Message, message: Strings.UsernameOrPasswordIsEmpty)
        } else {
            if email.validate(.Email) {
                if password.characters.count >= 6 && password.characters.count <= 20 {
                    return true
                } else {
                    alertWithOkButton(Strings.Message, message: Strings.PasswordCharacterCountLimited)
                }
            } else {
                alertWithOkButton(Strings.Message, message: Strings.InvalidEmail)
            }
        }
        return false
    }

    func validateSignupFlow(username: String, email: String, password: String) -> Bool {
        if username == "" || email == "" || password == "" {
            alertWithOkButton(Strings.Message, message: Strings.UsernameOrPasswordOrEmailIsEmpty)
        } else {
            if email.validate(.Email) {
                if password.characters.count >= 6 && password.characters.count <= 20 {
                    if username.characters.count >= 3 && username.characters.count <= 20 {
                        return true
                    } else {
                        alertWithOkButton(Strings.Message, message: Strings.UsernameCharacterCountLimited)
                    }
                } else {
                    alertWithOkButton(Strings.Message, message: Strings.PasswordCharacterCountLimited)
                }
            } else {
                alertWithOkButton(Strings.Message, message: Strings.InvalidEmail)
            }
        }
        return false
    }

    func alertWithOkButton(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okButton = UIAlertAction(title: Strings.Ok, style: .Default) { (action) in
        }
        alertVC.addAction(okButton)
        self.presentViewController(alertVC, animated: true, completion: nil)
    }

    func randomStringWithLength (len: Int) -> NSString {
        let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString: NSMutableString = NSMutableString(capacity: len)
        for _ in 0...len {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        return randomString
    }

    func compressForUpload(original: UIImage, withHeightLimit heightLimit: CGFloat, andWidthLimit widthLimit: CGFloat) -> UIImage {

        let originalSize = original.size
        var newSize = originalSize

        if originalSize.width > widthLimit && originalSize.width > originalSize.height {

            newSize.width = widthLimit
            newSize.height = originalSize.height * (widthLimit / originalSize.width)
        } else if originalSize.height > heightLimit && originalSize.height > originalSize.width {

            newSize.height = heightLimit
            newSize.width = originalSize.width * (heightLimit / originalSize.height)
        }
        // Scale the original image to match the new size.
        UIGraphicsBeginImageContext(newSize)
        original.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let compressedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return compressedImage
    }

    func checkDuplicate(className: String) -> Bool {
        if let allClass = try? Realm().objects(Class) {
            for item in allClass {
                if item.name == className {
                    return true
                }
            }
        }
        return false
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 0 {
            let studentName = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
            if (Int(studentName) > 100) {
                return false
            }
        }

        if textField.tag == 1 {
            let studentAge = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
            if (Int(studentAge) > 99) {
                return false
            }
        }
        return true
    }
}
