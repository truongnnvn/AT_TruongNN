//
//  TableViewCell.swift
//  AT_TruongNN_Realm_Student
//
//  Created by Truong Nguyen on 7/27/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentAge: UILabel!
    @IBOutlet weak var studentGender: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.avatarImageView.CircleImage()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
