//
//  RootViewController.swift
//  Bai5
//
//  Created by Truong Nguyen on 7/4/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let cellIdentifier = "Cell"
    @IBOutlet weak var myTableView: UITableView!
    
    var students = [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.myTableView.registerNib(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.getDataFromPList()
    }
    
    override func viewWillAppear(animated: Bool) {
        myTableView.reloadData()
    }
    
    func getDataFromPList() {
        let path = NSBundle.mainBundle().pathForResource("Student", ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!)
        
        for student in dataArray! {
            
            let avatar = student.objectForKey("avatar") as! String
            let name = student.objectForKey("name") as! String
            let age = student.objectForKey("age") as! String
            let gender = student.objectForKey("gender") as! Int
            
            let dataStudent = Student(name: name, age: age, gender: gender, avatar: avatar)
            students.append(dataStudent)
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CustomTableViewCell
        let student = students[indexPath.row]
        
        if let url = NSURL(string: student.avatar) {
            if let data = NSData(contentsOfURL: url) {
                cell.avatarImageView.image = UIImage(data: data)
                circleImage(cell.avatarImageView)
            }
        }
        cell.nameLabel.text = student.name
        cell.ageLabel.text = student.age
        if student.gender == 0 {
            cell.genderLabel.text = "Nam"
        } else {
            cell.genderLabel.text = "Nu"
        }
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let newVC = SecondViewController(nibName: "SecondViewController", bundle: nil)
        let student = students[indexPath.row]
        newVC.student = student
        newVC.indexOfStudent = indexPath.row
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    func circleImage(avatarImageView: UIImageView) {
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.masksToBounds = false
        avatarImageView.layer.borderColor = UIColor.whiteColor().CGColor
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
        avatarImageView.contentMode = .ScaleToFill
        avatarImageView.clipsToBounds = true
    }
}