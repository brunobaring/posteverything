//
//  CommentPresenter.swift
//  RioFatos
//
//  Created by Bruno Baring on 21/10/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit

class CommentPresenter {
    
    var comments: [Comment]
    var post: GetablePost
    
    init(post: GetablePost, comments: [Comment]) {
        self.post = post
        self.comments = comments
    }
}
