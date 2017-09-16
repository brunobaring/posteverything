//
//  User.swift
//  RioFatos
//
//  Created by Bruno Baring on 24/06/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import FirebaseAuth

struct User
{
    
    var uid: String?
    var name: String?
    var email: String
    var password: String?
    
    init(fireUser: FIRUser) {
        self.uid = fireUser.uid
        self.email = fireUser.email!
        self.name = fireUser.displayName
        self.password = ""
    }
    
    init(uid: String?, name: String?, email: String, password: String?) {
        self.uid = uid
        self.name = name
        self.email = email
        self.password = password
    }
}
