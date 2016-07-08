//
//  CustomTableViewCell.swift
//  Bai9
//
//  Created by Truong Nguyen on 7/6/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundViewCell: UIView!
    @IBOutlet weak var foodImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundViewCell.layer.cornerRadius = 10
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
