//
//  RootViewController.swift
//  CircleMenu_TruongNN
//
//  Created by Truong Nguyen on 7/7/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    weak var circleMenuView: CircleMenuView!
    let dataSource: [(title: String, imageName: String)] = [("Name 1", "but1"),
                                                            ("Name 2", "but2"),
                                                            ("Name 3", "but3"),
                                                            ("Name 4", "but4"),
                                                            ("Name 5", "but5")]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonShowView(sender: UIButton) {
        let circleMenuView = CircleMenuView(frame: self.view.bounds, radius: 120)
        self.view.addSubview(circleMenuView)
        self.circleMenuView = circleMenuView
        self.circleMenuView.delegate = self
    }
}

extension RootViewController: CircleMenuViewDelegate {
    
    func numberOfItem() -> Int! {
        return self.dataSource.count
    }
    
    func titleAtIndex(index: Int) -> String! {
        return self.dataSource[index].title
    }
    
    func imageNameAtIndex(index: Int) -> String! {
        return self.dataSource[index].imageName
    }
 }




