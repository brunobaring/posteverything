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

class FirebaseService
{
    
    let feedRef = FIRDatabase.database().reference().child("feed")
    let feedPhotoRef = FIRStorage.storage().reference().child("feedPhoto")

    func getFeedAutoIdReference() -> String {
        return self.getFeedReference().childByAutoId().key
    }
    
    func getFeedReference() -> FIRDatabaseReference {
        return FIRDatabase.database().reference().child("feed")
    }
    
    func login(_ user: User, completion: @escaping (FIRAuthResultCallback)) {
        FIRAuth.auth()!.signIn(withEmail: user.email, password: user.password!) { fireUser, fireError in
            completion(fireUser, fireError)
        }
    }
    
    func signUp(user: User, completion: @escaping (FIRAuthResultCallback)) {
        FIRAuth.auth()!.createUser(withEmail: user.email, password: user.password!) { fireUser, fireError in
            
            guard fireError != nil else
            {
                completion(fireUser, fireError)
                return
            }
            
            self.login(user, completion: { fireUser, fireError in
                completion(fireUser, fireError)
            })
        }
        
    }
    
    func logout(completion: (Error?) -> Void) {
        let user = Entities.shared.user
        if FIRAuth.auth()?.currentUser != nil && user != nil {
            do {
                try FIRAuth.auth()?.signOut()
                completion(nil)
            } catch let error as Error {
                print("erro de logout =>", error.localizedDescription)
                completion(error)
            }
        }
        completion(nil)
        return
        
    }
    
    func getFeedContent(user: User?, completion: @escaping ([Post]?, Error?) -> Void)
    {
        
        feedRef.queryOrdered(byChild: "createdAt").queryLimited(toLast: 3).observe( .value, with: { (snapshot) in
            guard let snapshotFeed = snapshot.value as? NSDictionary,
                let keys = snapshotFeed.allKeys as? [String] else {
                return
            }
            
            let feed = keys.flatMap({ key -> Post? in
                guard let feedPost = snapshotFeed[key] as? NSDictionary else {
                    return nil
                }
                
                return Post(dict: feedPost)
            })
            
            completion(feed, nil)
            
            
            
            
            return
            
            
        }) { (error) in
            print(error.localizedDescription)
            completion(nil, error)
        }
        
        
    }
    
    func saveNewPost(_ _post: Post, user: User, completion: @escaping (Error?) -> Void)
    {
        var post = _post

        let feedItemRef = self.feedRef.childByAutoId()
        
        for i in 0..<post.images.count {
            post.images[i].name = feedItemRef.key + "_\(post.images[i].position)"
        }
        
        uploadImages(ref: feedItemRef, uid: user.uid!, images: post.images){ (error) in
            print("error: \(error)")
            completion(error)
        }
        
        feedItemRef.setValue(post.contentToAnyObject())
        completion(nil)
        return
    }

    
    func uploadImages(ref: FIRDatabaseReference, uid: String, images: [PostImage], completion: @escaping (Error?) -> ()){
        
        var uploadedImageUrlsArray = [String]()
        var uploadCount = 0
        let imagesCount = images.count
        
        for image in images{
            
            guard let imageName = image.name else {
                completion(nil)
                return
            }
            
            let feedPhotoItemRef = feedPhotoRef.child("\(imageName)")
            
            guard let uploadData = image.image.jpeg(.lowest) else{
                return
            }
            
            // Upload image to firebase
            let uploadTask = feedPhotoItemRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    print(error)
                    completion(error)
                    return
                }
                if let imageUrl = metadata?.downloadURL()?.absoluteString{
                    uploadedImageUrlsArray.append(imageUrl)
                    uploadCount += 1
                    if uploadCount == imagesCount{

                        completion(nil)
                    }
                }
                completion(error)
                
            })
            
            
            observeUploadTaskFailureCases(uploadTask)
            observeProgressTask(uploadTask)
        }
    }
    
    
    func observeProgressTask(_ uploadTask: FIRStorageUploadTask) {
        uploadTask.observe(.progress) { snapshot in
            print(snapshot.progress) // NSProgress object
        }
    }
    
    func observeUploadTaskFailureCases(_ uploadTask: FIRStorageUploadTask){
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as? NSError {
                switch (FIRStorageErrorCode(rawValue: error.code)!) {
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
