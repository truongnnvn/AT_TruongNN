//
//  MyView.swift
//  Bai3
//
//  Created by Truong Nguyen on 6/27/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

protocol myViewDelegate {
    func didSelectMyView(myView: MyView, name: String, index: Int)
}

class MyView: UIView {

    var avatarImageView: UIImageView!
    var nameLabel: UILabel!
    var index = 0
    var delegate: myViewDelegate!
    
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
        if let delegate = self.delegate {
            delegate.didSelectMyView(self, name: self.nameLabel.text!, index: self.index)
        }
    }

}
