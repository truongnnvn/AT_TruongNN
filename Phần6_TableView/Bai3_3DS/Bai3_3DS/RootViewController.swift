//
//  RootViewController.swift
//  Bai3_3DS
//
//  Created by Truong Nguyen on 7/1/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    let cellIdentifier = "Cell"
    var names = [String]()
    var ages = [String]()
    var genders = [String]()
    var avatars = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        //myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        names = ["Nguyen", "Nhat", "Truong", "Asian"]
        ages = ["11", "12", "13", "14"]
        genders = ["Nam", "Nam", "Nam", "Nu"]
        avatars = ["1", "2", "3", "4"]
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
        }
        cell!.textLabel?.text = names[indexPath.row]
        cell!.detailTextLabel?.text = ages[indexPath.row] + "" + genders[indexPath.row]
        cell!.imageView?.image = UIImage(named: avatars[indexPath.row])
        return cell!
    }
}
