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
        
        let screenView = UIScreen.mainScreen().bounds
        let avatarWidth = screenView.size.width / 4
        let avatarHeigh:CGFloat = 100
        var row: CGFloat = 0
        var col:CGFloat = 0
        for i in 0...100 {
            var frame = CGRectMake(col * avatarWidth, row * avatarHeigh, avatarWidth, avatarHeigh)

            if frame.origin.x > screenView.size.width {
                row += 1
                col = 0
                frame = CGRectMake(col * avatarWidth, row * avatarHeigh, avatarWidth, avatarHeigh)
            }
            let myView = MyView(frame: frame)
            myView.avatarImageView.image = UIImage(named: "money")
            myView.nameLabel.text = "Name \(i)"
            myView.delegate = self
            self.view.addSubview(myView)
            col += 1
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
