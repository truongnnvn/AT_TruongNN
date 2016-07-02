//
//  RootViewController.swift
//  Bai4
//
//  Created by Truong Nguyen on 6/27/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    var avatars = [AvatarObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadData () {
        let a1 = AvatarObject(avatar: "money", name: "Truong")
        avatars.append(a1)
    }
    
    override func viewWillAppear(animated: Bool) {
        loadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        let avatarView = NSBundle.mainBundle().loadNibNamed("MyView", owner: self, options: [:]).last as! MyView
        avatarView.frame = CGRectMake(100, 100, 100, 130)
        avatarView.avatarImageView.image = UIImage(named: "\(avatars[0].avatar)")
        avatarView.nameLabel.text = avatars[0].name
        avatarView.delegate = self
        self.view.addSubview(avatarView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension RootViewController: myViewDelegate {
    func didSelectedImageView() {
        avatars[0].didSelected()
    }
}

