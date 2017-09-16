//
//  LoginViewModel.swift
//  RioFatos
//
//  Created by Bruno Baring on 29/08/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
        
    var profileManager: ProfileManager

    init(profileManager: ProfileManager) {
        self.profileManager = profileManager
    }

    func login(_ user: User, completion:  @escaping (FIRAuthResultCallback)) {
        MainService.sharedInstance.login(user) { (fireUser, fireError) in
            if fireError == nil {
                self.profileManager.didLogin()
            }
            completion(fireUser, fireError)

        }

    }

    
}
