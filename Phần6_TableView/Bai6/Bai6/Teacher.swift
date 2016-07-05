//
//  Teacher.swift
//  Bai6
//
//  Created by Truong Nguyen on 7/5/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import Foundation
import UIKit

class Teacher {
    var index:Int = 0
    var name:String = ""
    var age:Int!
    var gender:Int!
    var avatar:String = ""
    
    init(name: String, age: Int, gender: Int, avatar: String) {
        self.name = name
        self.age = age
        self.gender = gender
        self.avatar = avatar
    }
    
    func getInfoDictionary() -> NSMutableDictionary {
        
        let dic = NSMutableDictionary()
        
        dic.setValue(self.name, forKey: "name")
        
        return dic
    }
}