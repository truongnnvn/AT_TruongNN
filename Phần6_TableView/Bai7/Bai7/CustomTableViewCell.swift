//
//  CustomTableViewCell.swift
//  Bai7
//
//  Created by Truong Nguyen on 7/5/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactEmailLabel: UILabel!
    @IBOutlet weak var contactPhoneLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCircularAvatar() {
        contactImageView.layer.cornerRadius = contactImageView.bounds.size.width / 2.0
        contactImageView.layer.masksToBounds = true
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
       setCircularAvatar()
    }
    
    func configureWithContactEntry(contact: ContactEntry) {
        nameLabel.text = contact.name
        contactEmailLabel.text = contact.email ?? ""
        contactPhoneLabel.text = contact.phone ?? ""
        contactImageView.image = contact.image ?? UIImage(named: "default")
    }
}
