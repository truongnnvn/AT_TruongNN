//
//  SecondViewController.swift
//  Bai4
//
//  Created by Truong Nguyen on 7/1/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit


class SecondViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!

    
    var name = ""
    var age = ""
    var gender = ""
    var avatar = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        avatarImageView.image = UIImage(named: avatar)
        nameTextField.text = name
        ageTextField.text = age
        genderTextField.text = gender
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
