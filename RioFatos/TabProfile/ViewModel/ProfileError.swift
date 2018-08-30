//
//  ProfileError.swift
//  RioFatos
//
//  Created by Bruno Baring on 19/05/18.
//  Copyright © 2018 Bruno Baring. All rights reserved.
//

import Foundation

extension RequestError {
    
    struct Profile {
        enum ErrorType: Error {
            
            case unknown(description: String)
            case firebaseCommon(error: RequestError.Firebase)
            
            case fetchUser
            
        }
    }
}

extension ProfileController {
    
    func handleError(_ error: RequestError.Profile.ErrorType) {
        switch error {
        case .unknown:
            self.presentAlert(title: "Ops", message: "Unknown Error")
        case let .firebaseCommon(error: erro):
            RequestError.Firebase.handleError(onController: self, error: erro)
        case .fetchUser:
            self.presentAlert(title: "Ops", message: "Error fetching User")
        }
    }
    
}
