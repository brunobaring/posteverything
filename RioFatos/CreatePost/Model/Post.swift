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
    var url: String?
    var image: UIImage?
    var position: Int
}

struct GetablePost {
    var uid: String
    var title: String
    var description: String
    var imagesCount: Int
    var createdAt: Double
    var images = [PostImage]()
    var user: User
    var commentsCount: Int
    var comments: [Comment]?
    var heart: Heart

    init?(dict: NSDictionary, uid: String) {

        guard
            let title = dict["title"] as? String,
            let description = dict["description"] as? String,
            let imagesCount = dict["images_count"] as? Int,
            let imagesUrl = dict["images_url"] as? NSArray,
            let createdAt = dict["created_at"] as? Double,
            let userUid = dict["user_uid"] as? String,
            let name = dict["user_name"] as? String,
            let commentsCount = dict["comments_count"] as? Int,
            let heartCount = dict["hearts_count"] as? Int else {
                return nil
        }
        
        let didHeart = false
        let heart = Heart(counter: heartCount, didHeart: didHeart)
        let user = User(uid: userUid, name: name)
        // TODO: colocar as imagesURL dentro do modelo
        
        self.init(uid: uid,
                  title: title,
                  description: description,
                  imagesCount: imagesCount,
                  createdAt: createdAt,
                  user: user,
                  commentsCount: commentsCount,
                  heart: heart)
        
        for i in 0..<imagesUrl.count {
            guard let imageUrl = imagesUrl[i] as? String else {
                continue
            }
            self.images.append(PostImage(url: imageUrl, image: nil, position: i))
        }
        
    }
    
    init(
        uid: String,
        title: String,
        description: String,
        imagesCount: Int,
        createdAt: Double,
        user: User,
        commentsCount: Int,
        heart: Heart
        ) {
        self.uid = uid
        self.title = title
        self.description = description
        self.imagesCount = imagesCount
        self.createdAt = createdAt
        self.user = user
        self.commentsCount = commentsCount
        self.heart = heart
    }
    
    func fireUpdate(key: String, value: String) -> Any {
        return [
            key: value
        ]
    }
    
}

struct SendablePost {
    var uid: String?
    var title: String
    var description: String
    var images: [PostImage] = []
    var createdAt: String
    
    func contentToAnyObject() -> Any {
        let user = Entities.shared.user!
        return [
            "title": title,
            "description": description,
            "created_at": Double(createdAt),
            "images_count": images.count,
            "user_uid": user.uid!,
            "user_name": user.name!,
            "comments_count": 0,
            "hearts_count": 0
        ]
    }
}

