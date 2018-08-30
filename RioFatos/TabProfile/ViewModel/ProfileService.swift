//
//  ProfileService.swift
//  RioFatos
//
//  Created by Bruno Baring on 17/09/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation

class ProfileService {
    
    
    lazy var firebaseService = FirebaseService()
    
    func logout(completion: (RequestError.Login.ErrorType?) -> Void) {
        firebaseService.logout() { error in
            guard error == nil else {
                completion(.firebaseCommon(error: error!))
                return
            }
            completion(nil)
        }
    }

    func fetchUser(withUid uid: String, completion: @escaping (User?, RequestError.Profile.ErrorType?) -> Void) {
        
        self.firebaseService.fetchUser(withUid: uid, completion: { (snapshotValue, error) in
            if let error = error {
                completion(nil, .firebaseCommon(error: .match(error: error)))
                return
            }
            
            guard let snapshotDict = snapshotValue as? NSDictionary else {
                return
            }
            guard let user = User(dict: snapshotDict, uid: uid) else {
                return completion(nil, .fetchUser)
            }
            completion(user, nil)
            return
        })
        return
    }
    
}
