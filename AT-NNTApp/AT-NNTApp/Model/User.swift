//
//  User.swift
//  AT-NNTApp
//
//  Created by Truong Nguyen on 7/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import Foundation

class User {
    var username:String?
    var password:String?
    var email:String?
    var imageURL:String?
    
    init(username: String, password: String, email: String, imageURL: String) {
        self.username = username
        self.password = password
        self.email = email
        self.imageURL = imageURL
    }
    
    func getDictionary() -> Dictionary<String, String> {
        var user = Dictionary<String, String>()
        user["username"] = username
        user["password"] = password
        user["email"] = email
        user["imageURL"] = imageURL
        return user
    }
}