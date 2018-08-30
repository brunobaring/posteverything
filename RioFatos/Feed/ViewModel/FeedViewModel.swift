//
//  FeedVM.swift
//  RioFatos
//
//  Created by Bruno Baring on 23/07/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import PullToRefresh

class FeedPresenter
{
    
    private var feedPostPresenter : [FeedPostPresenter] = []
    var service = FeedService()
        
    func getPost(withIndex index: Int) -> GetablePost
    {
        return feedPostPresenter[index].feedPost
    }
    
    func getFeedContent(at position: Position?, completion: @escaping (RequestError.Feed.ErrorType?) -> Void)
    {
        
        var refreshPosition: RefreshPosition
        if let position = position {
            switch position {
            case .top:
                refreshPosition = .top(feedPostPresenter.first?.feedPost)
            case .bottom:
                refreshPosition = .bottom(feedPostPresenter.last?.feedPost)
            }
        }
        else {
            refreshPosition = .initial
        }
        
        service.getFeedContent(at: refreshPosition) { feed, error in
            guard error == nil else {
                completion(error!)
                return
            }

            let newFeedPostVM: [FeedPostPresenter]! = feed?.flatMap({ (post) -> FeedPostPresenter in
                FeedPostPresenter(feedPost: post)
            })
            
            if case .initial = refreshPosition {
                self.feedPostPresenter = newFeedPostVM
            }
            else {
                var newDiffedPosts = self.diffOn(newFeedPostVM: newFeedPostVM)
                
                if case .top = refreshPosition {
                    newDiffedPosts.append(contentsOf: self.feedPostPresenter)
                    self.feedPostPresenter = newDiffedPosts
                }
                else if case .bottom = refreshPosition {
                    self.feedPostPresenter.append(contentsOf: newDiffedPosts)
                }
            }
            completion(nil)
            return
        }
    }
    
    func diffOn(newFeedPostVM: [FeedPostPresenter]) -> [FeedPostPresenter] {
        let combinations = newFeedPostVM.flatMap { firstElement in (firstElement, self.feedPostPresenter.first { secondElement in (firstElement.feedPost.uid == secondElement.feedPost.uid) }) }

        return combinations.filter { $0.1 == nil }
            .flatMap { ($0.0) }
    }
    
    var count : Int { return feedPostPresenter.count }
}


extension FeedPresenter: HeartDelegate
{
    
    func didHeart(feedPost: GetablePost, completion: @escaping (RequestError.Feed.ErrorType?) -> Void) {
        service.didHeart(feedPost) { error in
            completion(error)
            return
        }
    }
    
}
