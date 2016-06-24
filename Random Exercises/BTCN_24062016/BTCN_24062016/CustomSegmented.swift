//
//  CustomSegmented.swift
//  BTCN_24062016
//
//  Created by Truong Nguyen on 6/24/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit
protocol mySegmentedDelegate {
    func showView(view: CustomSegmented, index: Int)
}

class CustomSegmented: UIView {
    
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!

    var delegate: mySegmentedDelegate!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @IBAction func changeView(sender: AnyObject) {
        if let delegate = self.delegate {
            let index = sender.tag
            delegate.showView(self, index: index)
            switch index {
            case 0:
                aButton.backgroundColor = UIColor.greenColor()
                bButton.backgroundColor = UIColor.clearColor()
                cButton.backgroundColor = UIColor.clearColor()
            case 1:
                aButton.backgroundColor = UIColor.clearColor()
                bButton.backgroundColor = UIColor.greenColor()
                cButton.backgroundColor = UIColor.clearColor()
            case 2:
                aButton.backgroundColor = UIColor.clearColor()
                bButton.backgroundColor = UIColor.clearColor()
                cButton.backgroundColor = UIColor.greenColor()
            default:
                break
            }
        }
    }
}

