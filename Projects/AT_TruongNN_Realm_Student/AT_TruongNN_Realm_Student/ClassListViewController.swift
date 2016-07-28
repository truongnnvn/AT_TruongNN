//
//  ClassListViewController.swift
//  AT_TruongNN_Realm_Student
//
//  Created by Truong Nguyen on 7/26/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit
import RealmSwift

class ClassListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    let realm = try! Realm()
    let cellIdentifier = "Cell"
    var classes: Results<Class>!
    var currentCreateAction: UIAlertAction!
    var filteredArray = [Class]()
    var shouldShowSearchResults = false
    var searchController: UISearchController!
    var customSearchController: CustomSearchController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.configUI()
        self.loadDataAndUpdateUI()
        // Search Bar
        configureCustomSearchController()
        // Notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(loadDataAndUpdateUI), name: "update", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(loadDataAndUpdateUI), name: "addNew", object: nil)
    }

    func configUI() {
        // Title
        self.title = "CLASSES"

        // Add button
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addClass))
        self.navigationItem.rightBarButtonItem = addButton

        // Register Class cell
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    func loadDataAndUpdateUI() {
        classes = realm.objects(Class)
        self.tableView.reloadData()
    }

    func addClass() {
        displayAlertToAddClassList(nil)
    }

    func displayAlertToAddClassList(updateClass: Class?) {

        var title = "Create New Class"
        var doneTitle = "Create"
        if updateClass != nil {
            title = "Update Class"
            doneTitle = "Update"
        }

        let alertController = UIAlertController(title: title, message: "Write the name of class.", preferredStyle: UIAlertControllerStyle.Alert)
        let createAction = UIAlertAction(title: doneTitle, style: UIAlertActionStyle.Default) { (action) -> Void in
            let className = alertController.textFields?.first?.text

            if updateClass != nil {
                // update mode
                do {
                    try self.realm.write({
                        updateClass?.name = className!
                        self.alertWithOkButton(Strings.Message, message: Strings.SaveSuccess)
                        self.loadDataAndUpdateUI()
                    })
                } catch {
                }

            } else { // Add new mode
                // Check duplicate
                if self.checkDuplicate(className!) {
                    self.alertWithOkButton(Strings.Message, message: Strings.DuplicatedClassName)
                } else {
                    let newClass = Class()
                    newClass.name = className!
                    newClass.id = self.classes.count + 1
                    do {
                        try self.realm.write({
                            self.realm.add(newClass)
                            self.alertWithOkButton(Strings.Message, message: Strings.CreateSuccess)
                            self.loadDataAndUpdateUI()
                        })
                    } catch {
                    }
                }
            }
        }

        alertController.addAction(createAction)
        createAction.enabled = false
        self.currentCreateAction = createAction

        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))

        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Class Name"
            textField.addTarget(self,
                action: #selector(ClassListViewController.listNameFieldDidChange(_:)),
                forControlEvents: UIControlEvents.EditingChanged)
            if updateClass != nil {
                textField.text = updateClass?.name
            }
        }

        self.presentViewController(alertController, animated: true, completion: nil)
    }

    // Enable the create action of the alert only if textfield text is not empty
    func listNameFieldDidChange(textField: UITextField) {
        self.currentCreateAction.enabled = textField.text?.characters.count > 0
    }
}

extension ClassListViewController: CustomSearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
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
        filteredArray = classes.filter({ (className) -> Bool in
            let classNameText = className.name as NSString
            return (classNameText.rangeOfString(searchString, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
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
        filteredArray = classes.filter({ (className) -> Bool in
            let classNameText = className.name as NSString
            return (classNameText.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        })
        // Reload the tableview.
        tableView.reloadData()
    }
}

extension ClassListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return self.filteredArray.count
        } else {
            return self.classes.count
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell!
        cell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
        if shouldShowSearchResults {
            let myClass = filteredArray[indexPath.row]
            cell.imageView?.image = UIImage(named: "class")
            cell.imageView?.BorderImage()
            cell.textLabel?.text = myClass.name
            cell.detailTextLabel?.text = "\(myClass.students.count) students"
        } else {
            let myClass = classes[indexPath.row]
            cell.imageView?.image = UIImage(named: "class")
            cell.imageView?.BorderImage()
            cell.textLabel?.text = myClass.name
            cell.detailTextLabel?.text = "\(myClass.students.count) students"
        }
        return cell
    }

    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Delete") { (deleteAction, indexPath) -> Void in
            // Deletion
            let classBeDeleted = self.classes[indexPath.row]
            do {
                try self.realm.write ({
                    self.realm.delete(classBeDeleted)
                    self.loadDataAndUpdateUI()
                })
                self.alertWithOkButton(Strings.Message, message: Strings.DeleteSuccess)
            } catch {
            }

        }
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Edit") { (editAction, indexPath) -> Void in

            // Editing will go here
            let classBeUpdated = self.classes[indexPath.row]
            self.displayAlertToAddClassList(classBeUpdated)
        }
        return [deleteAction, editAction]
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = ClassDetailViewController(nibName: "ClassDetailViewController", bundle: nil)
        detailVC.selectedClass = classes[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}