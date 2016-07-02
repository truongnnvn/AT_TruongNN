//
//  Student.swift
//  Bai3
//
//  Created by Truong Nguyen on 7/1/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import Foundation
import UIKit

class Student {
    var name:String = ""
    var age:String = ""
    var gender:String = ""
    var avatar:String = ""
    
    init(name: String, age: String, gender: String, avatar: String) {
        self.name = name
        self.age = age
        self.gender = gender
        self.avatar = avatar
    }
}