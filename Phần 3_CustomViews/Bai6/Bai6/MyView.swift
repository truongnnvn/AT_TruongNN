//
//  MyView.swift
//  Bai6
//
//  Created by Truong Nguyen on 6/28/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit
protocol myViewDelegate {
    func didSelectedImageView()
}
class MyView: UIView {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    var delegate: myViewDelegate!
    
    @IBAction func tapButton(sender: AnyObject) {
        if let delegate = self.delegate {
            delegate.didSelectedImageView()
        }
    }
}
