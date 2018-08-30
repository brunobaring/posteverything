//
//  LoginService.swift
//  RioFatos
//
//  Created by Bruno Baring on 17/09/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import FirebaseAuth


class LoginService {
    
    lazy var firebaseService = FirebaseService()
    
    func login(withIdentification identification: String, password: String, completion: @escaping (User?, RequestError.Login.ErrorType?) -> Void) {
        firebaseService.login(withIdentification: identification, password: password) { (fireUser, fireError) in
            if let fireError = fireError {
                completion(nil, RequestError.Login.match(error: fireError))
                return
            }
            else if let fireUser = fireUser {
                completion(User(fireUser: fireUser), nil)
//                self.firebaseService.fetchUser(withUid: fireUser.uid, completion: { (snapshotValue, error) in
//                    if let error = error {
//                        completion(nil, .firebaseCommon(error: .match(error: error)))
//                        return
//                    }
//
//                    guard let snapshotDict = snapshotValue as? NSDictionary else {
//                        return
//                    }
//                    guard let user = User(dict: snapshotDict, uid: fireUser.uid) else {
//                        return completion(nil, .fetchUser)
//                    }
//                    completion(user, nil)
//                    return
//                })
                return
            }
        }
    }
    
    func createUser(withIdentification identification: String, password: String, name: String, completion: @escaping (User?, RequestError.Login.ErrorType?) -> Void) {
        
        self.firebaseService.createUser(withIdentification: identification, password: password) { fireUser, fireError in
            if let fireError = fireError {
                completion(nil, RequestError.Login.ErrorType.firebaseCommon(error: RequestError.Firebase.match(error: fireError)))
                return
            }
            else if let fireUser = fireUser {
                self.firebaseService.setUserName(fireUser: fireUser, name: name, completion: { fireError in
                    if let fireError = fireError {
                        completion(nil, RequestError.Login.ErrorType.firebaseCommon(error: RequestError.Firebase.match(error: fireError)))
                        return
                    }
                    let user = User(fireUser: fireUser)
                    
                    guard
                        let uid = user.uid,
                        let name = user.name
                        else {
                            print("createerror user must have uid to be created.")
                            return
                    }
                    
                    let params = user.fireUpdate(key: "name", value: name)
                    self.firebaseService.set(params: params, uid: uid) { _, fireError in
                        if let fireError = fireError {
                            completion(nil, RequestError.Login.ErrorType.firebaseCommon(error: RequestError.Firebase.match(error: fireError)))
                        }
                        completion(user, nil)
                    }
                })
            }
        }
    }
}
