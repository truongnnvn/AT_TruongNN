//
//  Student.swift
//  Bai5
//
//  Created by Truong Nguyen on 7/4/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import Foundation
import UIKit

class Student {
    
    var name:String = ""
    var age:String = ""
    var gender:Int!
    var avatar:String = ""
    
    init(name: String, age: String, gender: Int, avatar: String) {
        self.name = name
        self.age = age
        self.gender = gender
        self.avatar = avatar
    }
}