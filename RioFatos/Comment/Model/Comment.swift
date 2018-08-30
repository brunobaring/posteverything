//
//  Comment.swift
//  RioFatos
//
//  Created by Bruno Baring on 24/06/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation

struct Comment {
    
    var id: String
    var text: String
    var user: User
    
    init?(dict: NSDictionary) {
        guard let id = dict["id"] as? String,
            let text = dict["text"] as? String,
        let userDict = dict["userName"] as? String else {
                return nil
        }

        self.id = id
        self.text = text
        self.user = User(uid: id, name: userDict)
    }
    
}

