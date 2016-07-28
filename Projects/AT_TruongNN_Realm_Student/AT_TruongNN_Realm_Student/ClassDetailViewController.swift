//
//  ClassDetailViewController.swift
//  AT_TruongNN_Realm_Student
//
//  Created by Truong Nguyen on 7/26/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit
import RealmSwift

class ClassDetailViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!

    var students: Results<Student>!
    var classes: Results<Class>!
    var selectedClass: Class!
    var selectedStudent: Student!
    let realm = try! Realm()
    let cellIdentifier = "Cell"
    var isDelete = false
    var filteredArray = [Student]()
    var shouldShowSearchResults = false
    var searchController: UISearchController!
    var customSearchController: CustomSearchController!
    var sections = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.configUI()
        self.loadDataAndUpdateUI()

        // Sort List
        sections = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
        sections.sortInPlace({ $0 < $1 })
        // Search Bar
        configureCustomSearchController()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ClassDetailViewController.update), name: "update", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ClassDetailViewController.addNew), name: "addNew", object: nil)
    }

    func configUI() {
        // Title
        self.title = "Students of class: \(selectedClass.name.uppercaseString)"

        // Add button
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addStudent))
        self.navigationItem.rightBarButtonItem = addButton

        // Register Class cell
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: cellIdentifier)

        // Search Bar
    }

    func update(notification: NSNotification) {
        let userInfo = notification.userInfo
        let indexPath = userInfo!["indexPath"] as! NSIndexPath
        self.tableView.beginUpdates()
        switch self.isDelete {
        case true: self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        case false: self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        self.tableView.endUpdates()
        students = realm.objects(Student.self).filter("idClass = %@", selectedClass.id)
    }

    func addNew() {
        let indexToInsert = NSIndexPath(forRow: self.students.count - 1, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexToInsert], withRowAnimation: .Fade)
    }

    func loadDataAndUpdateUI() {
        students = realm.objects(Student.self).filter("idClass = %@", selectedClass.id)
    }

    func addStudent() {
        let addStudentVC = AddStudentViewController(nibName: "AddStudentViewController", bundle: nil)
        addStudentVC.selectedClass = selectedClass
        navigationController?.pushViewController(addStudentVC, animated: true)
    }
}

extension ClassDetailViewController: CustomSearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    // SearchBar
    func configureSearchController() {
        // Initialize and perform a minimum configuration to the search controller.
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()

        // Place the search bar view to the tableview headerview.
        tableView.tableHeaderView = searchController.searchBar
    }

    func configureCustomSearchController() {
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRectMake(0.0, 0.0, tableView.frame.size.width, 30.0), searchBarFont: UIFont(name: "Futura", size: 16.0)!, searchBarTextColor: UIColor.blueColor(), searchBarTintColor: UIColor.blackColor())

        customSearchController.customSearchBar.placeholder = "Search in this bar..."
        tableView.tableHeaderView = customSearchController.customSearchBar

        customSearchController.customDelegate = self
    }

    // MARK: UISearchBarDelegate functions

    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }

        searchController.searchBar.resignFirstResponder()
    }

    // MARK: UISearchResultsUpdating delegate function

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else {
            return
        }

        // Filter the data array and get only those countries that match the search text.
        filteredArray = students.filter({ (studentName) -> Bool in
            let studentNameText = studentName.name as NSString
            return (studentNameText.rangeOfString(searchString, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        })

        // Reload the tableview.
        tableView.reloadData()
    }

    // MARK: CustomSearchControllerDelegate functions

    func didStartSearching() {
        shouldShowSearchResults = true
        tableView.reloadData()
    }

    func didTapOnSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
    }

    func didTapOnCancelButton() {
        shouldShowSearchResults = false
        tableView.reloadData()
    }

    func didChangeSearchText(searchText: String) {
        // Filter the data array and get only those countries that match the search text.
        filteredArray = students.filter({ (studentName) -> Bool in
            let studentNameText = studentName.name as NSString
            return (studentNameText.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        })
        // Reload the tableview.
        tableView.reloadData()
    }
}

extension ClassDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sections.count
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section].uppercaseString
    }

    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return self.sections
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return self.students.count
        if shouldShowSearchResults {
            return filteredArray.count
        }
        else {
            return self.students.count
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? TableViewCell

        if shouldShowSearchResults {
            selectedStudent = filteredArray[indexPath.row]
            cell?.studentName.text = "\(selectedStudent.name)"
            cell?.studentAge.text = "Age: \(selectedStudent.age)"
            switch selectedStudent.gender {
            case true: cell?.studentGender.text = "Gender: Male"
            default: cell?.studentGender.text = "Gender: Female"
            }
            cell?.avatarImageView.image = FileManager.instance.loadFile(selectedStudent.avatarImage, typeDirectory: .DocumentDirectory)
        }
        else {
            selectedStudent = students[indexPath.row]
            cell?.studentName.text = "\(selectedStudent.name)"
            cell?.studentAge.text = "Age: \(selectedStudent.age)"
            switch selectedStudent.gender {
            case true: cell?.studentGender.text = "Gender: Male"
            default: cell?.studentGender.text = "Gender: Female"
            }
            cell?.avatarImageView.image = FileManager.instance.loadFile(selectedStudent.avatarImage, typeDirectory: .DocumentDirectory)
        }

        return cell!
    }

    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Delete") { (deleteAction, indexPath) -> Void in

            // Deletion
            let studentBeDeleted = self.students[indexPath.row]
            do {
                try self.realm.write ({
                    self.isDelete = true
                    self.realm.delete(studentBeDeleted)
                    NSNotificationCenter.defaultCenter().postNotificationName("update", object: nil, userInfo: ["indexPath": indexPath])
                })
                self.alertWithOkButton(Strings.Message, message: Strings.DeleteSuccess)
            } catch {
            }

        }
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Edit") { (editAction, indexPath) -> Void in

            // Editing will go here
            let detailVC = AddStudentViewController(nibName: "AddStudentViewController", bundle: nil)
            detailVC.selectedStudent = self.students[indexPath.row]
            detailVC.isUpdated = true
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        return [deleteAction, editAction]
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = AddStudentViewController(nibName: "AddStudentViewController", bundle: nil)
        detailVC.selectedStudent = students[indexPath.row]
        detailVC.indexPath = indexPath
        detailVC.isUpdated = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
}