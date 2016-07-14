//
//  HomeTableViewCell.swift
//  AT-NNTApp
//
//  Created by Truong Nguyen on 7/14/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageRestaurant: UIImageView!
    @IBOutlet weak var nameRestaurantLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var shortDesLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        imageRestaurant.BorderImage()
        imageRestaurant.contentMode = .ScaleAspectFill
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
