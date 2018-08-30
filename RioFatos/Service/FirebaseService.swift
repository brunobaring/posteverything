//
//  Firebase.swift
//  RioFatos
//
//  Created by Bruno Baring on 17/07/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

extension FIRDatabaseQuery {
    
    func queryLimit(to position: RefreshPosition) -> FIRDatabaseQuery {
        
        let postLimit = Environment.sharedInstance.refreshPostQty
        
        switch position {
        case let .top(post):
            guard let post = post else {
                return self
            }
            return self
                .queryStarting(atValue: post.uid)
                .queryLimited(toFirst: postLimit)
        case let .bottom(post):
            guard let post = post else {
                return self
            }
            return self
                .queryEnding(atValue: post.uid)
                .queryLimited(toLast: postLimit)
        case .initial:
            return self
                .queryLimited(toLast: postLimit)
        }
    }
    
}

class FirebaseService
{
    
    let databaseRef = FIRDatabase.database().reference()
    let storageRef = FIRStorage.storage().reference()
    
    var feedRef: FIRDatabaseReference {
        return databaseRef.child("feed")
    }
    
    var feedUserRef: FIRDatabaseReference {
        return databaseRef.child("user")
    }
    
    var feedPhotoRef: FIRStorageReference {
        return storageRef.child("feed_photo")
    }
    
    func getFeedAutoIdReference() -> String {
        return self.getFeedReference().childByAutoId().key
    }
    
    func getFeedReference() -> FIRDatabaseReference {
        return FIRDatabase.database().reference().child("feed")
    }
    
    func login(withIdentification identification: String, password: String, completion: @escaping (FIRAuthResultCallback)) {
        FIRAuth.auth()!.signIn(withEmail: identification, password: password) { fireUser, fireError in
            completion(fireUser, fireError)
            return
        }
    }
    
    func createUser(withIdentification identification: String, password: String, completion: @escaping (FIRAuthResultCallback)) {
        FIRAuth.auth()!.createUser(withEmail: identification, password: password) { fireUser, fireError in
            completion(fireUser, fireError)
        }
    }
    
    func setUserName(fireUser: FIRUser, name: String, completion: @escaping (FIRUserProfileChangeCallback)) {
        let changeRequest = fireUser.profileChangeRequest()
        changeRequest.displayName = name
        changeRequest.commitChanges { error in
            completion(error)
        }
    }
    
    func fetchUser(withUid uid: String, completion: @escaping (Any?, Error?) -> Void) {

        feedUserRef
            .child(uid)
            .observeSingleEvent(of: .value, with: { (snapshot) in
                completion(snapshot.value, nil)
                return
            }) { (error) in
                completion(nil, error)
        }
        
    }
    
    func set(params: Any, uid: String, completion: @escaping (FIRDatabaseReference?, Error?) -> Void) {
        
        self.feedUserRef
            .child(uid)
            .setValue(params, withCompletionBlock: { (error, ref) in
                completion(ref, error)
            })
        return
    }
    
    func set(ref: FIRDatabaseReference, urlsImage: [PostImage], completion: @escaping (RequestError.Firebase?) -> Void) {
        
        let formatedImageUrl = format(images: urlsImage)
        ref
            .child("images_url")
            .setValue(formatedImageUrl, withCompletionBlock: { (error, ref) in
                if let error = error {
                    completion(.match(error: error))
                    return
                }
                completion(nil)
            })
    }
    
    enum PostCountAction {
        case increase
        case decrease
    }
    
    func didPost(post: SendablePost, uid: String, completion: @escaping (RequestError.Firebase?) -> Void) {
        
        var isPosting = true
        feedRef.keepSynced(true)
        feedUserRef.child(uid).runTransactionBlock({ (currentData) -> FIRTransactionResult in
            print("111",currentData)
            print("222",currentData.value)
            print("333",currentData.value as? [String: AnyObject])
            print("444",uid)
            guard
                var user = currentData.value as? [String : AnyObject],
                let postUid = post.uid else {
                completion(.match(text: "userDataNotFound"))
                return FIRTransactionResult.abort()
            }
            var posts: [String]
            if let _posts = user["posts"] as? [String] {
                posts = _posts
                for i in 0..<posts.count {
                    if postUid == posts[i] {
                        posts.remove(at: i)
                        isPosting = false
                    }
                    else if i == posts.count - 1 {
                        posts.append(postUid)
                    }
                }
            }
            else {
                posts = [postUid]
            }
            
            user["posts"] = posts as AnyObject?
            currentData.value = user
            return FIRTransactionResult.success(withValue: currentData)
            
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
                completion(.match(error: error))
                return
            }
            completion(nil)
            return
        }
    }
    
    func didHeart(post: GetablePost, completion: @escaping (RequestError.Firebase?) -> Void) {
        var isHearting = true
        feedUserRef.child(Entities.shared.user!.uid!).runTransactionBlock ({ currentData -> FIRTransactionResult in
            guard var user = currentData.value as? [String : AnyObject] else {
                completion(.match(text: "userDataNotFound"))
                return FIRTransactionResult.abort()
            }
            var hearts: [String]
            if let _hearts = user["hearts"] as? [String] {
                hearts = _hearts
                for i in 0..<hearts.count {
                    if post.uid == hearts[i] {
                        hearts.remove(at: i)
                        isHearting = false
                        break
                    }
                    else if i == hearts.count - 1 {
                        hearts.append(post.uid)
                    }
                }
            }
            else {
                hearts = [post.uid]
            }
            
            user["hearts"] = hearts as AnyObject?
            currentData.value = user
            return FIRTransactionResult.success(withValue: currentData)
            
        }){ (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
                completion(.match(error: error))
                return
            }
            
            self.feedRef.child(post.uid).runTransactionBlock ({ currentData -> FIRTransactionResult in
                guard var postData = currentData.value as? [String : AnyObject] else {
                    completion(.match(text: "postDataNotFound"))
                    return FIRTransactionResult.abort()
                }
                
                var heartsCount = postData["hearts_count"] as? Int ?? 0
                if isHearting {
                    heartsCount += 1
                }
                else {
                    heartsCount -= 1
                }
                
                postData["hearts_count"] = heartsCount as AnyObject?
                currentData.value = postData
                return FIRTransactionResult.success(withValue: currentData)
                
            }){ (error, committed, snapshot) in
                if let error = error {
                    print(error.localizedDescription)
                    completion(.match(error: error))
                    return
                }
                completion(nil)
                return
            }
        }
    }
    
    func logout(completion: (RequestError.Firebase?) -> Void) {
        let user = Entities.shared.user
        if FIRAuth.auth()?.currentUser != nil && user != nil {
            do {
                try FIRAuth.auth()?.signOut()
                completion(nil)
                return
            } catch let error {
                print("erro de logout =>", error.localizedDescription)
                completion(.match(error: error))
                return
            }
        }
        completion(.match(text: "userIsAlreadyLoggedOut"))
        return
    }
    
    func getFeedContent(at position: RefreshPosition, completion: @escaping ([GetablePost]?, RequestError.Firebase?) -> Void)
    {
        feedRef.keepSynced(true)
        feedRef
            .queryOrderedByKey()
            .queryLimit(to: position)
            .observeSingleEvent(of: .value, with: { (snapshot) in
                
                print(snapshot.value ?? "nao veio nada no feed")
                guard let snapshotFeed = snapshot.value as? NSDictionary,
                    let keys = snapshotFeed.allKeys as? [String] else {
                        completion(nil, .match(text: "feedDataNotFound"))
                        return
                }
                
                var feed = keys.flatMap({ key -> GetablePost? in
                    guard let feedPost = snapshotFeed[key] as? NSDictionary else {
                        completion(nil, .match(text: "keyNotFound"))
                        return nil
                    }
                    
                    return GetablePost(dict: feedPost, uid: key)
                })
                
                feed = feed.sorted(by: { (post1, post2) -> Bool in
                    post1.createdAt < post2.createdAt
                })
                
                completion(feed, nil)
                return
                
            }) { (error) in
                completion(nil, .match(error: error))
                return
        }
        
        
    }
    
    func saveNewPost(_ _formPost: SendablePost, uid: String, completion: @escaping (RequestError.Firebase?) -> Void)
    {
        
        let postItemRef = self.feedRef.childByAutoId()
        var formPost = _formPost
        formPost.uid = postItemRef.key
        
        postItemRef.setValue(formPost.contentToAnyObject()) { (error, ref) in
            if let error = error {
                completion(.match(error: error))
                return
            }
            
            let photoRef = self.feedPhotoRef.child(postItemRef.key)

            self.uploadImages(ref: photoRef, uid: uid, images: formPost.images){ (images, error) in
                if error != nil {
                    completion(error)
                    return
                }
                
                self.set(ref: postItemRef, urlsImage: images!, completion: { (error) in
                    if error != nil {
                        completion(error)
                        return
                    }
                    self.didPost(post: formPost, uid: uid, completion: { (error) in
                        completion(error)
                        return
                    })
                })
            }
        }
    }
    
    func format(images: [PostImage]) -> Any {
        
        var dict = [String : String]()
        
        for i in 0..<images.count {
            dict[String(i)] = images[i].url
        }
        return dict
    }
    
    func uploadImages(ref: FIRStorageReference, uid: String, images: [PostImage], completion: @escaping ([PostImage]?, RequestError.Firebase?) -> ()){
        
        var postImages = images
        var uploadedImageUrlsArray = [String]()
        var uploadCount = 0
        let imagesCount = images.count
        
        for i in 0..<postImages.count {
            
            let feedPhotoItemRef =
                ref
                    .child("\(images[i].position)")
                    .child("image")
            
            guard let image = postImages[i].image, let uploadData = image.jpeg(.lowest) else{
                completion(nil, .match(text: "imageOrQualityNotFound"))
                return
            }
            
            // Upload image to firebase
            let uploadTask = feedPhotoItemRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    completion(nil, .match(error: error!))
                    return
                }
                if let imageUrl = metadata?.downloadURL()?.absoluteString {
                    uploadedImageUrlsArray.append(imageUrl)
                    postImages[i].url = imageUrl
                    uploadCount += 1
                    if uploadCount == imagesCount{
                        completion(postImages, nil)
                        return
                    }
                }
                else {
                    completion(nil, .match(text: "imageUrlNotAvailable"))
                    return
                }
            })
            
            observeUploadTaskFailureCases(uploadTask)
            observeProgressTask(uploadTask)
        }
    }
    
    func observeProgressTask(_ uploadTask: FIRStorageUploadTask) {
        uploadTask.observe(.progress) { snapshot in
            print(snapshot.progress ?? "cade o progresso?") // NSProgress object
        }
    }
    
    func observeUploadTaskFailureCases(_ uploadTask: FIRStorageUploadTask){
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error {
                switch (FIRStorageErrorCode(rawValue: error._code)!) {
                case .objectNotFound:
                    print("File doesn't exist")
                    break
                case .unauthorized:
                    print("User doesn't have permission to access file")
                    break
                case .cancelled:
                    print("User canceled the upload")
                    break
                    
                case .unknown:
                    print("Unknown error occurred, inspect the server response")
                    break
                default:
                    print("A separate error occurred, This is a good place to retry the upload.")
                    break
                }
            }
        }
    }
    
}
