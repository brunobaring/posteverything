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
    private init() {}
    
    
    
    func addUserListener() {
        FIRAuth.auth()!.addStateDidChangeListener() { auth, fireUser in
            print("auth =>", auth.currentUser?.email)
            print("fireUser =>", fireUser?.email)
            print("name =>", fireUser?.displayName)
            guard let fireUser = fireUser else {
                return
            }
            self.user = User(fireUser: fireUser)
        }

    }

    func isUserLogged() -> Bool {
        if FIRAuth.auth()?.currentUser != nil && user == nil {
            user = User(fireUser: FIRAuth.auth()!.currentUser!, name: nil)
            return true
        }
        else if FIRAuth.auth()?.currentUser == nil {
            return false
        }
        else if user != nil {
            return true
        }
        
        return false
        
    }
    
}





