//
//  RootViewController.swift
//  Bai8
//
//  Created by Truong Nguyen on 7/5/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit
import AddressBook
import Contacts

class RootViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {

    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "Cell"
    var contactStore = CNContactStore()
    var contact = [ContactEntry]()
    var filteredContact = [ContactEntry]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registed TableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: cellIdentifier)
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.barTintColor = UIColor.blueColor()
        searchController.searchBar.barStyle = .BlackTranslucent
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        requestAccessToContacts { (success) in
            if success {
                self.retrieveContacts({ (success, contacts) in
                    self.tableView.hidden = !success
                    //self.noContactsLabel.hidden = success
                    if success && contacts?.count > 0 {
                        self.contact = contacts!
                        self.tableView.reloadData()
                    } else {
                    }
                })
            }
        }
    }
    
    func requestAccessToContacts(completion: (success: Bool) -> Void) {
        let authorizationStatus = CNContactStore.authorizationStatusForEntityType(CNEntityType.Contacts)
        
        switch authorizationStatus {
        case .Authorized: completion(success: true) // authorized previously
        case .Denied, .NotDetermined: // needs to ask for authorization
            self.contactStore.requestAccessForEntityType(CNEntityType.Contacts, completionHandler: { (accessGranted, error) -> Void in
                completion(success: accessGranted)
            })
        default: // not authorized.
            completion(success: false)
        }
    }
    
    func retrieveContacts(completion: (success: Bool, contacts: [ContactEntry]?) -> Void) {
        var contacts = [ContactEntry]()
        do {
            let contactsFetchRequest = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactImageDataKey, CNContactImageDataAvailableKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey])
            try contactStore.enumerateContactsWithFetchRequest(contactsFetchRequest, usingBlock: { (cnContact, error) in
                if let contact = ContactEntry(cnContact: cnContact) { contacts.append(contact) }
            })
            completion(success: true, contacts: contacts)
        } catch {
            completion(success: false, contacts: nil)
        }
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        self.filteredContact = contact.filter { item in
            return item.name.lowercaseString.containsString(searchText.lowercaseString)
        }
        tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredContact.count
        }
        return self.contact.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CustomTableViewCell
        //let index = people[indexPath.row]
        let contactObject: ContactEntry!
        if searchController.active && searchController.searchBar.text != "" {
            contactObject = filteredContact[indexPath.row]
        } else {
            contactObject = contact[indexPath.row]
        }
        
        cell.nameLabel.text = contactObject.name
        cell.detailTextLabel?.text = contactObject.phone
        return cell
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

