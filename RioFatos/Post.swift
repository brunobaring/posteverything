//
//  Post.swift
//  RioFatos
//
//  Created by Bruno Baring on 24/06/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

struct PostImage {
    
    var image: UIImage
    var name: String?
    var position: Int
    var downloadUrl: String?
    
}

struct Post
{
    
    var uid: String?
    
    init(title: String, description: String, username: String, createdAt: Double) {
        self.username = username
//        self.uid = user.uid
        self.title = title
        self.description = description
        self.createdAt = createdAt
        
//        images.enumerated().map({ (i, image) in
//            let postImage = PostImage(image: image, name: nil, position: i, downloadUrl: nil)
//            self.images.append(postImage)
//        })
    }
    
    init(title: String, description: String, images: [UIImage], createdAt: Double, user: User) {
        self.username = user.name
        self.uid = user.uid
        self.title = title
        self.description = description
        self.createdAt = createdAt
        
        images.enumerated().map({ (i, image) in
            let postImage = PostImage(image: image, name: nil, position: i, downloadUrl: nil)
            self.images.append(postImage)
        })
    }
    
    var title: String
//    var _title: NSString? {
//        return NSString(string: title)
//    }
    
    var description: String
//    var _description: NSString? {
//        return NSString(string: description)
//    }

    var images: [PostImage] = []
//    var _images: NSArray? {
//        return NSArray(array: images)
//    }
    
    var createdAt: Double
    var _createdAt: NSNumber {
        return NSNumber(value: createdAt)
    }
    
    var username: String?
    var comments = [Comment]()
    var share: Share?
    var heart: Heart?
    
    func contentToAnyObject() -> Any {
        return [
            "title": title,
            "description": description,
            "createdAt": _createdAt,
            "user": uid,
            "username": username,
            "images_count": images.count
        ]
    }
    
    init?(dict: NSDictionary) {
        guard
            let title = dict["title"] as? String,
            let description = dict["description"] as? String,
            let createdAt = dict["createdAt"] as? Double else {
//            let username = dict["username"] as? String else{
                return nil
        }
        
        self.init(title: title,
                  description: description,
                  username: "user jabba",//username,
                  createdAt: createdAt)
    }
}
