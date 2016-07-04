//
//  RootViewController.swift
//  Bai4
//
//  Created by Truong Nguyen on 7/1/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!
    
    let cellIdentifier = "Cell"
        
    var names = [String]()
    var ages = [String]()
    var genders = [String]()
    var avatars = [String]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Student List"
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        names = ["Nguyen", "Nhat", "Truong", "Asian"]
        ages = ["11", "12", "13", "14"]
        genders = ["Nam", "Nam", "Nam", "Nu"]
        avatars = ["1", "2", "3", "4"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        cell.imageView?.image = UIImage(named: avatars[indexPath.row])
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let newVC = SecondViewController(nibName: "SecondViewController", bundle: nil)
        newVC.name = names[indexPath.row]
        newVC.age = ages[indexPath.row]
        newVC.gender = genders[indexPath.row]
        newVC.avatar = avatars[indexPath.row]
        navigationController?.pushViewController(newVC, animated: true)
    }
}