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
    
    func didHeart(feedPost: Post, completion: @escaping (Bool) -> Void)
    func didHeart(feedPost: Post, withError error: String)
    
}

protocol FeedActionAnimatable {
    
    func turnAnimate(toState state: Bool)
    
}

protocol FeedActionCountable {

    func setCounter(_ count: Int)

}

protocol FeedActionButton {
    
    
    
}
