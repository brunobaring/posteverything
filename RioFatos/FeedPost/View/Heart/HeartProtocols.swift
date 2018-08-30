//
//  HeartProtocols.swift
//  RioFatos
//
//  Created by Bruno Baring on 21/07/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation

protocol HeartProtocol
{
    
    mutating func toggleHeart()
    mutating func updateHeartCounter(withHeartStatus heartStatus: Bool)
    
}

protocol HeartDelegate
{
    
    func didHeart(feedPost: GetablePost, completion: @escaping (RequestError.Feed.ErrorType?) -> Void)
    
}

protocol FeedActionAnimatable {
    
    func turnAnimate(toState state: Bool)
    
}

protocol FeedActionCountable {

    func setCounter(_ count: Int)

}
