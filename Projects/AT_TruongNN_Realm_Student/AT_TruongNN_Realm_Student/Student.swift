//
//  Student.swift
//  AT_TruongNN_Realm_Student
//
//  Created by Truong Nguyen on 7/26/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import Foundation
import RealmSwift

class Student: Object {
    dynamic var id = 0
    dynamic var idClass = 0
    dynamic var name = ""
    dynamic var age = 0
    dynamic var avatarImage = ""
    dynamic var createAt = NSDate()
    dynamic var gender = false
}