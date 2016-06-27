//
//  AvatarObject.swift
//  Bai4
//
//  Created by Truong Nguyen on 6/27/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import Foundation
import UIKit

class AvatarObject {
    var avatar: String = ""
    var name: String = ""
    
    init (avatar: String, name: String) {
        self.avatar = avatar
        self.name = name
    }
    
    func didSelected() {
        print("avatar object")
    }
}