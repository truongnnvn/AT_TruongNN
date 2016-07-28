//
//  Class.swift
//  AT_TruongNN_Realm_Student
//
//  Created by Truong Nguyen on 7/26/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import Foundation
import RealmSwift

class Class: Object {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var createAT = NSDate()
    let students = List<Student>()
}