//
//  User.swift
//  RioFatos
//
//  Created by Bruno Baring on 24/06/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import FirebaseAuth
import UIKit

struct User {
    
    var uid: String?
    var name: String?
    var identification: String?
    var posts: [String]?
    var hearted: [String]?
    
    init(fireUser: FIRUser, name: String?) {
        self.uid = fireUser.uid
        self.identification = fireUser.email
        self.name = name
    }
    
    init(fireUser: FIRUser) {
        self.uid = fireUser.uid
        self.identification = fireUser.email
        self.name = fireUser.displayName
    }
    
    init?(dict: NSDictionary, uid: String) {
        print(dict)
        guard
            let identification = dict["identification"] as? String,
            let name = dict["name"] as? String
            else {
                return nil
        }
        
        var posts: [String] = []
        if let postsDict = dict["posts"] as? NSArray {
            posts = postsDict.map { (value) -> String in
                guard let value = value as? String else {
                    return ""
                }
                return value
            }
        }
        
        var hearted: [String] = []
        if let heartsDict = dict["hearts"] as? NSArray {
            hearted = heartsDict.map { (value) -> String in
                guard let value = value as? String else {
                    return ""
                }
                return value
            }
        }
        
        self.init(
            uid: uid,
            name: name,
            identification: identification,
            posts: posts,
            hearted: hearted
        )
    }

    init(uid: String, name: String, identification: String, posts: [String], hearted: [String]) {
        self.uid = uid
        self.name = name
        self.identification = identification
        self.posts = posts
        self.hearted = hearted
    }

    init(uid: String, name: String) {
        self.uid = uid
        self.name = name
    }
    
    init(uid: String) {
        self.uid = uid
    }
    
    init() {}
    
    func fireUpdate(key: String, value: String) -> Any {
        return [
            key: value,
            "identification": identification
        ]
    }
    
}
