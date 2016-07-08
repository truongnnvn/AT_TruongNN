//
//  RootViewController.swift
//  CustomDatePickerView
//
//  Created by Truong Nguyen on 7/6/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayLabel.text = "1" + " / " + "1" + " / " + "1970"
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        let frame = CGRectMake(0, 100, 375 , 181)
        let myView = NSBundle.mainBundle().loadNibNamed("CustomDatePicker", owner: nil, options: nil).last as! CustomDatePicker
        myView.frame = frame
        myView.delegate = self
        self.view.addSubview(myView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RootViewController: PickerViewProtocol {
    func donePickerView(day: Int, month: Int, year: Int) {
        self.displayLabel.text = "\(day)" + " / " + "\(month)" + " / " + "\(year)"
    }
    
    func cancelPickerView() {
        self.displayLabel.text = ""
    }
}