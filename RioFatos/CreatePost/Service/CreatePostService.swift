//
//  CreatePostService.swift
//  RioFatos
//
//  Created by Bruno Baring on 17/09/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation

class CreatePostService {
    
    
    lazy var firebaseService = FirebaseService()

    func saveNewPost(_ post: SendablePost, completion: @escaping (RequestError.CreatePost.ErrorType?) -> Void)
    {
        guard let user = Entities.shared.user, let uid = user.uid else {
            completion(.userMustBeLoggedToPost)
            return
        }
        firebaseService.saveNewPost(post, uid: uid) { (error) in

            if error != nil {
                completion(.firebaseCommon(error: error!))
            }
            else {
                completion(nil)
            }
            return
        }
    }
}
