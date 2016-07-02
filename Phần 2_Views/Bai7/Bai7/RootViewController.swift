//
//  RootViewController.swift
//  Bai7
//
//  Created by Truong Nguyen on 6/24/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    @IBOutlet var numberButton: [UIButton]!
    @IBOutlet weak var resultTextField: UITextField!
    
    var number1:Int = 0
    var number2:Int = 0
    var sign: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func actionInputNumber(sender: AnyObject) {
        if sender.tag == 0 {
            input(0)
        } else if sender.tag == 1 {
            input(1)
        } else if sender.tag == 2 {
            input(2)
        } else if sender.tag == 3 {
            input(3)
        } else if sender.tag == 4 {
            input(4)
        } else if sender.tag == 5 {
            input(5)
        } else if sender.tag == 6 {
            input(6)
        } else if sender.tag == 7 {
            input(7)
        } else if sender.tag == 8 {
            input(8)
        } else if sender.tag == 9 {
            input(9)
        }
    }
    
    @IBAction func actionCalculate(sender: AnyObject) {
        if sender.tag == 0 {
            let s1 = Int(resultTextField.text!)
            self.number1 = s1!
            self.resultTextField.text = ""
            self.sign = "+"
            print("+")
        } else if sender.tag == 1 {
            let s1 = Int(resultTextField.text!)
            self.number1 = s1!
            self.resultTextField.text = ""
            self.sign = "-"
            print("-")
        } else if sender.tag == 2 {
            print("*")
        } else if sender.tag == 3 {
            print("/")
        } else if sender.tag == 4 {
            self.resultTextField.text = "0"
        }
    }

    @IBAction func actionEqual(sender: AnyObject) {
        let s2 = Int(resultTextField.text!)
        self.number2 = s2!
        var result:Int = 0
        if sign == "+" {
            result = number1 + number2        }
        if sign == "-" {
            result = number1 - number2
        }
        if sign == "*" {
            result = number1 * number2
        }
        if sign == "/" {
            result = number1/number2
        }
        self.resultTextField.text = String(result)
    }
    
    func input(num: Int) -> Int {
        var str:String = resultTextField.text!
        str = str + "\(num)"
        self.resultTextField.text = str
        return Int(resultTextField.text!)!
    }
}
