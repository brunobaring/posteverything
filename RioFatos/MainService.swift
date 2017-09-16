//
//  MainService.swift
//  RioFatos
//
//  Created by Bruno Baring on 24/06/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import FirebaseAuth

class MainService
{

    static let sharedInstance = MainService()
    private init() {}
    
    var firebaseService = FirebaseService()
    var user = Entities.shared.user
    
    func login(_ user: User, completion: @escaping (FIRAuthResultCallback)) {
        firebaseService.login(user) { (fireUser, fireError) in
            guard fireError == nil else{
                completion(fireUser, fireError)
                return
            }
            self.user = User(fireUser: fireUser!)
            completion(fireUser, fireError)
        }
    }
    
    func signUp(user: User, completion: @escaping (FIRAuthResultCallback)) {
        FIRAuth.auth()!.createUser(withEmail: user.email, password: user.password!) { fireUser, fireError in
            completion(fireUser, fireError)
        }
    }
    
    func logout(completion: (Error?) -> Void) {
        firebaseService.logout() { (error) in
            guard error == nil else {
                completion(error)
                return
            }
            Entities.shared.user = nil
            completion(nil)
        }
    }
    
    func setInitialConfig()
    {
        let environment = Environment.sharedInstance
        //        environment.descriptionCharLeftQtyMax = 40
    }
    
    func getFeedContent(completion: @escaping ([Post]?, Error?) -> Void)
    {
        
        firebaseService.getFeedContent(user: user) { (feed, error) in
            completion(feed, error)
        }

        
//        var feed = [FeedPost]()
//        feed.append(FeedPost(
//            post: Post(title: "Post 1",
//                       description: "nao sei o q",
//                       images: [],
//                       createdAt: 0
//            ),
//            username: "Bruno",
//            comments: [Comment(id: 2,
//                               text: "masss meeo",
//                               user: User(uid: "123",
//                                          name: "bruno",
//                                          email: "jabbajoe@gmail.com",
//                                          password: "123"
//            )),
//                       ],
//            share: Share(),
//            heart: Heart(counter: 12,
//                         didHeart: false
//            )
//        ))
//        
//        feed.append(FeedPost(
//            post: Post(title: "post 1",
//                       description: "nao sei o q",
//                       images: [],
//                       createdAt: 0
//            ),
//            username: "Bruno",
//            comments: [Comment(id: 1,
//                               text: "masss meeo",
//                               user: User(uid: "456",
//                                          name: "bruno",
//                                          email: "jabbajoe@gmail.com",
//                                          password: "123"
//            )),
//                       ],
//            share: Share(),
//            heart: Heart(counter: 12,
//                         didHeart: false
//            )
//        ))
//        
//        completion(feed, nil)
//        return
    }
    
    
    func saveNewPost(_ post: Post, completion: @escaping (CustomError?) -> Void)
    {

        firebaseService.saveNewPost(post, user: user!) { (error) in
            completion(.firebaseError(error: error))
        }
    }
    
    
}
