//
//  FeedVM.swift
//  RioFatos
//
//  Created by Bruno Baring on 23/07/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation

class FeedVM
{
    
    private var feedPostVM : [FeedPostVM]?
    
    init(feedPostVM: [FeedPostVM]?)
    {
//        typealias CallBack = (_ result: [Int]) -> Void
//        func longCalculations (completion: @escaping CallBack) {
//            let backgroundQ = DispatchQueue.global()
//            let group = DispatchGroup()
//            
//            var fill:[Int] = []
//            for number in 0..<100 {
//                group.enter()
//                backgroundQ.async(group: group,  execute: {
//                    if number > 50 {
//                        fill.append(number)
//                    }
//                    group.leave()
//                    
//                })
//            }
//            
//            group.notify(queue: DispatchQueue.main, execute: {
//                print("All Done"); completion(fill)
//            }) 
//        }
//        
//        longCalculations(){
//            print($0)
//        }
        self.feedPostVM = feedPostVM
    }
    
    func getPost(withIndex index: Int) -> Post
    {
        return feedPostVM![index].feedPost
    }
    
    
    func getFeedContent(completion: @escaping (Error?) -> Void)
    {
        MainService.sharedInstance.getFeedContent() { feed, error in
            guard error == nil else { completion(error); return }
            
            for i in 0..<feed!.count
            {
                self.feedPostVM?.append(FeedPostVM(feed![i]))
            }
            completion(nil)
            return
        }
    }
    
    var count : Int { return feedPostVM?.count ?? 1 }
}


extension FeedVM: HeartDelegate
{
    
    func didHeart(feedPost: Post, completion: @escaping (Bool) -> Void) {
//        MainService.didheartpost criar essa funcao
        completion(true)
    }
    
    func didHeart(feedPost: Post)
    {
        
        print("didHeart")
    }
    
    func didHeart(feedPost: Post, withError error: String)
    {
        print(error)
    }
    
}
