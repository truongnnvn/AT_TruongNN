//
//  RootViewController.swift
//  Bai7
//
//  Created by Truong Nguyen on 7/5/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit
import AddressBook
import Contacts

class RootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellIdentifier = "ContactCell"
    var contactStore = CNContactStore()
    var contacts = [ContactEntry]()
    var indexOfChars = [String]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.title = "Address Book"
        
        indexOfChars = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "S", "R", "T", "X", "Y", "Z"]
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        requestAccessToContacts { (success) in
            if success {
                self.retrieveContacts({ (success, contacts) in
                    self.tableView.hidden = !success
                    //self.noContactsLabel.hidden = success
                    if success && contacts?.count > 0 {
                        self.contacts = contacts!
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return indexOfChars.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return indexOfChars
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        let temp = indexOfChars as NSArray
        return temp.indexOfObject(title)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CustomTableViewCell
        let entry = contacts[indexPath.row]
        cell.configureWithContactEntry(entry)
        cell.layoutIfNeeded()
        
        return cell
    }
}
