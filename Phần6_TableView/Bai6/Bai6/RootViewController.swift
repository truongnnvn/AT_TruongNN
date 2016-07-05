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
    let headerCellIdentifier = "headerCell"
    @IBOutlet weak var tableView: UITableView!
    
    var students = [Student]()
    var teachers = [Teacher]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.automaticallyAdjustsScrollViewInsets = true
        let nib = UINib(nibName: "CustomHeaderViewCell", bundle: nil)
        self.tableView.registerNib(nib, forHeaderFooterViewReuseIdentifier: headerCellIdentifier)

        self.getDataFromPList()
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    func getDataFromPList() {
        let path = NSBundle.mainBundle().pathForResource("Student", ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!)
        
        for student in dataArray! {
            
            let avatar = student.objectForKey("avatar") as! String
            let name = student.objectForKey("name") as! String
            let age = student.objectForKey("age") as! Int
            let gender = student.objectForKey("gender") as! Int
            
            let dataStudent = Student(name: name, age: age, gender: gender, avatar: avatar)
            students.append(dataStudent)
        }
        
        let path1 = NSBundle.mainBundle().pathForResource("Teacher", ofType: "plist")
        let dataArray1 = NSArray(contentsOfFile: path1!)
        
        for teacher in dataArray1! {
            
            let avatar = teacher.objectForKey("avatar") as! String
            let name = teacher.objectForKey("name") as! String
            let age = teacher.objectForKey("age") as! Int
            let gender = teacher.objectForKey("gender") as! Int
            
            let dataTeacher = Teacher(name: name, age: age, gender: gender, avatar: avatar)
            teachers.append(dataTeacher)
        }

    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func updateData(indexRow: Int, student: Dictionary<String, AnyObject>) {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let dataArray = NSMutableArray(contentsOfFile: String(path))
        dataArray!.replaceObjectAtIndex(indexRow, withObject: student)
        dataArray!.writeToFile(String(path), atomically: false)
    }

    // TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 2
        default:
            return students.count
        }
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
        cell.ageLabel.text = String(student.age)
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
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    //Header
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = NSBundle.mainBundle().loadNibNamed("CustomHeaderViewCell", owner: self, options: nil)[0] as! CustomHeaderViewCell

        switch section {
        case 0:
            //headerCell.backgroundColor = UIColor.blueColor()
            headerCell.nameLabel.text = teachers[section].name
            headerCell.avatarImageView.image = UIImage(named: teachers[section].avatar)
            headerCell.avatarImageView.image = UIImage(named: teachers[section].avatar)
            headerCell.avatarImageView.contentMode = .ScaleAspectFit
        default:
            //headerCell.backgroundColor = UIColor.redColor()
            headerCell.nameLabel.text = "Second"
            headerCell.avatarImageView.image = UIImage(named: "2")
            headerCell.avatarImageView.contentMode = .ScaleAspectFit
        }
        
        return headerCell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
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