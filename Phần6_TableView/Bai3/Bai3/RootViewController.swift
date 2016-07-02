//
//  RootViewController.swift
//  Bai3
//
//  Created by Truong Nguyen on 7/1/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellIdentifier = "Cell"
    @IBOutlet weak var myTableView: UITableView!
    
    var students = [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        
        let student1 = Student(name: "Truong", age: "28", gender: "Nam", avatar: "1")
        let student2 = Student(name: "Nguyen", age: "27", gender: "Nu", avatar: "2")
        let student3 = Student(name: "Nhat", age: "29", gender: "Nam", avatar: "3")
        let student4 = Student(name: "Asian", age: "22", gender: "Nam", avatar: "4")
        students.append(student1)
        students.append(student2)
        students.append(student3)
        students.append(student4)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        let student = students[indexPath.row]
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
        }
        cell!.imageView?.image = UIImage(named: student.avatar)
        cell!.textLabel?.text = student.name
        cell!.detailTextLabel?.text = student.age + "   " + student.gender
        cell!.accessoryType = .DisclosureIndicator
        
        return cell!
    }
}