//
//  SecondViewController.swift
//  Bai4
//
//  Created by Truong Nguyen on 7/1/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

//protocol SecondViewDelegate {
//    func update(index: Int, dataUpdated: Student)
//}

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderSegmented: UISegmentedControl!

    var student:Student!
    var imageNSURL:NSURL!
    var isChangedImage = false
    var randomStringForAvatarImage = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        
        //Declare TapGesture
        self.avatarImageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(SecondViewController.selectAvatarImageTapGesture(_:)))
        tap.delegate = self
        avatarImageView.addGestureRecognizer(tap)
    
        //
        if let student = student {
            if let url = NSURL(string: student.avatar) {
                if let data = NSData(contentsOfURL: url) {
                    avatarImageView.image = UIImage(data: data)
                    avatarImageView.layer.borderWidth = 1
                    avatarImageView.layer.masksToBounds = false
                    avatarImageView.layer.borderColor = UIColor.whiteColor().CGColor
                    avatarImageView.layer.cornerRadius = 7
                    avatarImageView.contentMode = .ScaleAspectFill
                    avatarImageView.clipsToBounds = true
                }
            }
            nameTextField.text = student.name
            ageTextField.text = String(student.age)
            genderSegmented.selectedSegmentIndex = student.gender
        }
        
        //
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.updateInfo))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    func updateInfo() {
        if isChangedImage {
            student.avatar = String(imageNSURL)
        }
        student.name = nameTextField.text ?? ""
        student.age = Int(ageTextField.text!)
        student.gender = genderSegmented.selectedSegmentIndex
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("Student1.plist")
        
        let dict: NSMutableDictionary = [:]
        //saving values
        dict.setObject(student.avatar, forKey: "avatar")
        dict.setObject(student.name, forKey: "name")
        dict.setObject(student.age, forKey: "age")
        dict.setObject(student.gender, forKey: "gender")
        //...
        //writing to GameData.plist
        dict.writeToFile(path, atomically: true)
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        print("Saved GameData.plist file is --> \(resultDictionary?.description)")
        
        alert("Message", message: "Successfully")
    }

    func selectAvatarImageTapGesture(sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .PhotoLibrary
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let pickedImage:UIImage
        
        if let info = editingInfo, let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            pickedImage = editedImage
        } else {
            pickedImage = image
        }
        
        avatarImageView.image = pickedImage
        randomStringForAvatarImage = randomStringWithLength(10) as String
        isChangedImage = true
        
        let fileManager = NSFileManager.defaultManager()
        let rootPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let filePath = "\(rootPath)/\(randomStringForAvatarImage).jpg"
        let imageData = UIImageJPEGRepresentation(pickedImage, 1.0)
        fileManager.createFileAtPath(filePath, contents: imageData, attributes: nil)
        
        if (fileManager.fileExistsAtPath(filePath)) {
            imageNSURL = NSURL.init(fileURLWithPath: filePath)
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _ in 0...len
        {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        return randomString
    }
    
    func alert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okButton = UIAlertAction(title: "OK", style: .Default) { (action) in
            self.navigationController?.popViewControllerAnimated(true)
        }
        alertVC.addAction(okButton)
        self.presentViewController(alertVC, animated: true, completion: nil)
    }
}
