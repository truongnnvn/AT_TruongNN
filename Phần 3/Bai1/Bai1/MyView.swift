//
//  MyView.swift
//  Bai1
//
//  Created by Truong Nguyen on 6/27/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class MyView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configView(frame)
    }

    func configView(frame: CGRect) {
        //add UIImage View
        let imgFrame = CGRectMake(0, 0, frame.size.width, frame.size.height - frame.size.height / 5)
        let imageView = UIImageView(image: UIImage(named: "blank-user"))
        imageView.frame = imgFrame
        imageView.contentMode = .ScaleToFill
        self.addSubview(imageView)
        
        //add label
        let label = UILabel(frame: CGRectMake(0, frame.size.height - frame.size.height / 5, frame.size.width, frame.size.height / 5))
        label.text = "No Name"
        label.textAlignment = .Center
        label.backgroundColor = UIColor.lightGrayColor()
        label.textColor = UIColor.greenColor()
        self.addSubview(label)
        
        //Add Button
        let button = UIButton(type: .Custom)
        button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        button.backgroundColor = UIColor.clearColor()
        button.addTarget(self, action: #selector(self.tapButton(_:)), forControlEvents: .TouchUpInside)
        self.addSubview(button)
    }
    @objc private func tapButton(sender: AnyObject) {
        print("Test myView")
    }
}
