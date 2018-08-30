//
//  CreatePostPresenter.swift
//  RioFatos
//
//  Created by Bruno Baring on 21/07/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit

struct CreatePostPresenter
{
    
    var title: String?
    var description: String?
    var images: [PostImage]?
    var createdAt: Double?
    
    var service = CreatePostService()
    
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
        var postImages = [PostImage]()
        for (i,image) in images.enumerated() {
            postImages.append(PostImage(url: nil, image: image, position: i))
        }
        self.images = postImages
    }
    
    mutating func sendPost(completion: @escaping (RequestError.CreatePost.ErrorType?) -> Void)
    {
        
        let validation = sendPostValidation()
        
        guard
            validation.error == nil,
            let formPost = validation.formPost else {
                completion(validation.error)
                return
        }
        
        service.saveNewPost(formPost) { (error) in
            completion(error)
            return
        }
        
    }
    
    func sendPostValidation() -> (error: RequestError.CreatePost.ErrorType?, formPost: SendablePost?) {
        guard Entities.shared.user != nil else {
            return (.userMustBeLoggedToPost, nil)
        }
        
        guard let title = title else {
            return (.mustFillTitle, nil)
        }
        
        guard let description = description else {
            return (.mustFillDescription, nil)
        }
        
        guard let images = images else {
            return (.mustFillImages, nil)
        }
        
        return (nil, SendablePost(uid: nil,
                                  title: title,
                                  description: description,
                                  images: images,
                                  createdAt: NSDate().timeIntervalSince1970.description
            )
        )
    }
}
