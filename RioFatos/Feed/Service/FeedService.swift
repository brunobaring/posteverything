//
//  FeedService.swift
//  RioFatos
//
//  Created by Bruno Baring on 17/09/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation

class FeedService {
    
    
    lazy var firebaseService = FirebaseService()
    
    func didHeart(_ post: GetablePost, completion: @escaping ( RequestError.Feed.ErrorType?) -> Void)
    {
        firebaseService.didHeart(post: post) { error in
            guard error == nil else {
                completion(.firebaseCommon(error: error!))
                return
            }
            completion(nil)
            return
        }
    }
    
    func getFeedContent(at position: RefreshPosition, completion: @escaping ([GetablePost]?, RequestError.Feed.ErrorType?) -> Void)
    {
        firebaseService.getFeedContent(at: position) { (feed, error) in
            if let feed = feed {
                completion(feed.reversed(), nil)
                return
            }
            completion(nil, .firebaseCommon(error: error!))
            return
        }
    }
    
}
