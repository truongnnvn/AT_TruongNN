//
//  RootViewController.swift
//  Bai7
//
//  Created by Truong Nguyen on 6/28/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    @IBOutlet weak var percentTextfield: UITextField!
    
    let myView = NSBundle.mainBundle().loadNibNamed("MyView", owner: nil, options: nil).last as! MyView
    @IBAction func changeSlider(sender: AnyObject) {
        self.myView.setPercentNumber(percentTextfield.text!)
        self.percentTextfield.resignFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        myView.frame = CGRectMake(160, 200, 60, 300)
        myView.percentLabel.text = "50%"
        myView.delegate = self
        percentTextfield.text = "50%"
        self.view.addSubview(myView)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        myView.touchesMoved(touches, withEvent: event)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension RootViewController: myViewDelegate {
    func sentData(myView: MyView, percent: CGFloat) {
        percentTextfield.text = "\(Int(percent))%"
    }
}