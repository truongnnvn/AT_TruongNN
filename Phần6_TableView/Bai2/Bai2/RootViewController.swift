//
//  RootViewController.swift
//  Bai2
//
//  Created by Truong Nguyen on 7/1/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let cellIdentifier = "Cell"
    @IBOutlet weak var myTableView: UITableView!
    
    var users = ["Nguyen Nhat Truong", "Phung Chi Minh Quang", "Nguyen Thanh Su", "Le Phuong Tien", "Ho Van Su", "Ho Dac Thinh", "Ho Van Dai", "Ngo Viet Khoi", "AsianTech"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = users[indexPath.row]
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
}
