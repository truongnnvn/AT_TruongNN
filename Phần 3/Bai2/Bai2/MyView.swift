//
//  MyView.swift
//  Bai2
//
//  Created by Truong Nguyen on 6/27/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class MyView: UIView {
    var avatarImageView: UIImageView!
    var nameLabel: UILabel!

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
        avatarImageView = UIImageView(image: UIImage(named: "blank-user"))
        avatarImageView.frame = imgFrame
        avatarImageView.contentMode = .ScaleToFill
        self.addSubview(avatarImageView)
        
        //add label
        nameLabel = UILabel(frame: CGRectMake(0, frame.size.height - frame.size.height / 5, frame.size.width, frame.size.height / 5))
        nameLabel.text = "No Name"
        nameLabel.textAlignment = .Center
        nameLabel.backgroundColor = UIColor.lightGrayColor()
        nameLabel.textColor = UIColor.greenColor()
        self.addSubview(nameLabel)
        
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
