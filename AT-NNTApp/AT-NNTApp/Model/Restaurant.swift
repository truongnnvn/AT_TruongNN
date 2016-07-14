//
//  Restaurant.swift
//  AT-NNTApp
//
//  Created by Truong Nguyen on 7/13/16.
//  Copyright © 2016 demo. All rights reserved.
//

import Foundation
import UIKit

class Restaurant {
    var image: String = ""
    var name: String = ""
    var address: String = ""
    var shortDes: String = ""
    var longDes: String = ""
    var latitude: Double?
    var longtitude: Double?
    var favorite: Bool?
    var food: [String] = []
    
    init(image: String, name: String, address: String, shortDes: String, longDes: String, latitude: Double, longtitude: Double, favorite: Bool, food: [String]) {
        self.image = image
        self.name = name
        self.address = address
        self.shortDes = shortDes
        self.longDes = longDes
        self.latitude = latitude
        self.longtitude = longtitude
        self.favorite = favorite
        self.food = food
    }
}