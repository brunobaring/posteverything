//
//  LoginPresenter.swift
//  RioFatos
//
//  Created by Bruno Baring on 29/08/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import FirebaseAuth

class LoginPresenter {
        
    var profileManager: ProfileManager
    var service = LoginService()
    
    init(profileManager: ProfileManager) {
        self.profileManager = profileManager
    }
    
    func login(withIdentification _identification: String?, _password: String?, completion: @escaping (RequestError.Login.ErrorType?) -> Void) {
        
        guard
            let identification = _identification,
            identification.count > 0 else {
                completion(.emailIsEmpty)
                return
        }
        
        guard
            let password = _password,
            password.count > 0 else {
                completion(.passwordIsEmpty)
                return
        }
        
        service.login(withIdentification: identification, password: password) { (user, error) in
            if let error = error {
                completion(error)
                return
            }
            Entities.shared.user = user
            self.profileManager.didLogin()
            completion(nil)
        }
        
    }
    
    func signUp(withIdentification identification: String, password: String, name: String, completion: @escaping (RequestError.Login.ErrorType?) -> Void) {
        
        service.createUser(withIdentification: identification, password: password, name: name) { (user, error) in
            if let error = error {
                completion(error)
            }
            Entities.shared.user = user
            self.profileManager.didLogin()
            completion(nil)
        }
        
    }

    
}
