//
//  CreatePostViewModel.swift
//  RioFatos
//
//  Created by Bruno Baring on 21/07/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit

struct CreatePostViewModel
{
    
    var title: String?
    var description: String?
    var images: [UIImage]?
    var createdAt: Double?
    
    
    mutating func updateTitle(_ title: String)
    {
        self.title = title
    }
    
    mutating func updateDescription(_ description: String)
    {
        self.description = description
    }
    
    mutating func updateThumbnailImages(_ images: [UIImage])
    {
        self.images = images
    }
    
    mutating func sendPost(completion: @escaping (CustomError?) -> Void)
    {

        let validation = sendPostValidation()
        
        guard
            validation.error == nil,
            let post = validation.post else {
                completion(validation.error)
                return
        }
        
        MainService.sharedInstance.saveNewPost(post) { (error) in
            completion(nil)
            return
        }
    
    }
    
    func sendPostValidation() -> (error: CustomError?, post: Post?) {
        guard let user = Entities.shared.user else {
            return ((.userMustBeLoggedToPost(title: "Ops", message: "User must be logged to post")),nil)
        }
        
        guard let post = postInfoIsValidated() else {
            return ((.couldNotCreatePost(title: "Ops", message: "Could not create post. Check info")), nil)
        }
        
        return (nil, post)
    }
    
    func postInfoIsValidated() -> Post? {
        guard let title = title,
            let description = description,
            let images = images else {
                return nil
        }
        
        return Post(title: title,
                        description: description,
                        images: images,
                        createdAt: NSDate().timeIntervalSince1970,
                        user: MainService.sharedInstance.user!
        )
    }
    
}
