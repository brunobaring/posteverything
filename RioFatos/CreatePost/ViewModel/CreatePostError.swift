//
//  CreatePostError.swift
//  RioFatos
//
//  Created by Bruno Baring on 24/09/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import FirebaseAuth


extension CreatePostController {
    
    func handleError(_ error: RequestError.CreatePost.ErrorType) {
        switch error {
        case .unknown:
            self.presentAlert(title: "Ops", message: "Unknown Error")
        case .userMustBeLoggedToPost:
            self.presentAlert(title: "Ops", message: "User is not signed In")
        case .mustFillTitle:
            self.presentAlert(title: "Ops", message: "You must fill the title field")
        case .mustFillDescription:
            self.presentAlert(title: "Ops", message: "You must fill the description field")
        case .mustFillImages:
            self.presentAlert(title: "Ops", message: "You must choose one or more pictures.")
        case let .firebaseCommon(error: erro):
            RequestError.Firebase.handleError(onController: self, error: erro)
            
        }
    }
    
}

extension RequestError {
    
    struct CreatePost {
        
        enum ErrorType: Error {
            
            case unknown(description: String)
            
            case userMustBeLoggedToPost
            case mustFillTitle
            case mustFillDescription
            case mustFillImages
            
            case firebaseCommon(error: RequestError.Firebase)
            
        }
    }
}
