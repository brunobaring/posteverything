//
//  Shared.swift
//  RioFatos
//
//  Created by Bruno Baring on 12/09/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import FirebaseAuth

class Entities
{
    
    var user: User?
    
    static let shared = Entities()
    private init() {
        FIRAuth.auth()!.addStateDidChangeListener() { auth, fireUser in
                        print("auth =>", auth.currentUser)
                        print("fireUser =>", fireUser?.displayName)
            if fireUser != nil {
                self.user = User(fireUser: fireUser!)
            }
        }
    }
    
}
