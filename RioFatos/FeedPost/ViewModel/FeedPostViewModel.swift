//
//  FeedPostVM.swift
//  RioFatos
//
//  Created by Bruno Baring on 09/07/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation

struct FeedPostPresenter
{
    
    var feedPost: GetablePost
    var delegate: HeartDelegate! = nil
 
    init(feedPost: GetablePost) {
        self.feedPost = feedPost
    }
    
}


extension FeedPostPresenter: CommentProtocol
{
    
    mutating func add(comment: Comment)
    {
//        self.feedPost.comments.append(comment)
    }
    
}


extension FeedPostPresenter: HeartProtocol
{
    
    var heartCounter:Int?
    {
        get
        {
            return self.feedPost.heart.counter
        }
    }
    
    var didHeart:Bool?
    {
        get
        {
            return self.feedPost.heart.didHeart
        }
        set (n)
        {
            var heart = self.feedPost.heart
            if heart.didHeart != n
            {
                heart.didHeart = !heart.didHeart
                updateHeartCounter(withHeartStatus: heart.didHeart)
                // TODO: send change to api
                // if sending is ok,
//                delegate.didHeart(feedPost: feedPost)
                //else
                //delegate.didHeart(feedPost: timeLinePost, withError: "Send api error")
            }
        }
    }
    
    mutating func toggleHeart()
    {
            
        didHeart = !didHeart!
    }
    
    mutating func updateHeartCounter(withHeartStatus heartStatus: Bool)
    {
        if heartStatus
        {
            self.feedPost.heart.counter = heartCounter! + 1
        }
        else
        {
            self.feedPost.heart.counter = heartCounter! - 1
        }
    }
    
}
