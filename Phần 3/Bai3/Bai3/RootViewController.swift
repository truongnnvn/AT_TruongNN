//
//  RootViewController.swift
//  Bai3
//
//  Created by Truong Nguyen on 6/27/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Custom View"
        for i in 0...2 {
            for j in 0...2 {
                let frame = CGRectMake(30 + CGFloat(j) * 100, 100 + CGFloat(i) * 135, 100, 125)
                let myView = MyView(frame: frame)
                myView.avatarImageView.image = UIImage(named: "money")
                myView.nameLabel.text = "Name \(i + j * 3)"
                myView.index = i + j * 3
                myView.delegate = self
                self.view.addSubview(myView)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension RootViewController: myViewDelegate {
    func didSelectMyView(myView: MyView, name: String, index: Int) {
        print("Selected Name: \(name) - index: \(index)")
    }
}
