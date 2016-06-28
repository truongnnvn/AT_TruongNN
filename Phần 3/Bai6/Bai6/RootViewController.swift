//
//  RootViewController.swift
//  Bai6
//
//  Created by Truong Nguyen on 6/28/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Custom View"
        self.scrollView = UIScrollView()
        let screenFrame = UIScreen.mainScreen().bounds//lấy kích thước của toàn màn hình
        self.scrollView.frame = screenFrame
        self.scrollView.contentSize = CGSize(width: screenFrame.size.width, height: CGFloat(100) / CGFloat(4) * CGFloat(120))
        self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        self.view.addSubview(scrollView)
        
        let screenView = UIScreen.mainScreen().bounds
        let avatarWidth = screenView.size.width / 4
        let avatarHeigh:CGFloat = 100
        var row: CGFloat = 0
        var column:CGFloat = 0
        for i in 0...100 {
            var frame = CGRectMake(column * avatarWidth, row * avatarHeigh, avatarWidth, avatarHeigh)
            if frame.origin.x > screenView.size.width {
                row += 1
                column = 0
                frame = CGRectMake(column * avatarWidth, row * avatarHeigh, avatarWidth, avatarHeigh)
            }
            let myView = NSBundle.mainBundle().loadNibNamed("MyView", owner: nil, options: nil).last as! MyView
            myView.frame = frame
            myView.avatarImageView.image = UIImage(named: "money")
            myView.nameLabel.text = "Name \(i)"
            myView.delegate = self
            self.scrollView.addSubview(myView)
            column += 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension RootViewController: myViewDelegate {
    func didSelectedImageView() {
        print("Test")
    }
}
