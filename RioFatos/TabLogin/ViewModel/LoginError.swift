//
//  LoginError.swift
//  RioFatos
//
//  Created by Bruno Baring on 20/09/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import FirebaseAuth


extension LoginController {
    
    func handleError(_ error: RequestError.Login.ErrorType) {
        switch error {
        case .unknown:
            self.presentAlert(title: "Ops", message: "Unknown Error")
        case .emailIsEmpty:
            self.presentAlert(title: "Ops", message: "You must fill your email")
        case .passwordIsEmpty:
            self.presentAlert(title: "Ops", message: "You must fil your password")
        case .couldNotSetNameForUser:
            self.presentAlert(title: "Ops", message: "Your account was created, but we had a problem with your usename")
        case .emailAlreadyInUse:
            self.presentAlert(title: "Ops", message: "The email is taken")
        case let .weakPassword(reason: reason):
            self.presentAlert(title: "Ops", message: reason)
            
        case .operationNotAllowed:
            self.presentAlert(title: "Ops", message: "Operation not Allowed")
        case .invalidMail:
            self.presentAlert(title: "Ops", message: "The email you entered is invalid")
        case .userDisabled:
            self.presentAlert(title: "Ops", message: "User is disabled")
        case .wrongPassword:
            self.presentAlert(title: "Ops", message: "The password your entered is wrong")
        case let .firebaseCommon(error: erro):
            RequestError.Firebase.handleError(onController: self, error: erro)

        case .noValidName:
            self.presentAlert(title: "Ops", message: "User must set e valid Name")
        case .fetchUser:
            self.presentAlert(title: "Ops", message: "Error fetching User")
        }
    }
    
}

extension RequestError {
    
    struct Login {
        enum ErrorType: Error {
            
            case unknown(description: String)
            case emailIsEmpty
            case passwordIsEmpty
            case couldNotSetNameForUser
            case noValidName
            
            //createUser
            case emailAlreadyInUse
            case weakPassword(reason: String)
            
            //login
            case operationNotAllowed
            case invalidMail
            case userDisabled
            case wrongPassword
            case fetchUser

            case firebaseCommon(error: RequestError.Firebase)
            
        }
        
        static func match(error: Error) -> ErrorType {
            
            guard let fireError = FIRAuthErrorCode(rawValue: error._code) else {
                return .unknown(description: error.localizedDescription)
                //Error not found in Firebase bag
            }
            
            switch fireError {
            case .errorCodeEmailAlreadyInUse:
                return .emailAlreadyInUse
            case .errorCodeWeakPassword:
                return .weakPassword(reason: error.localizedDescription)
            case .errorCodeOperationNotAllowed:
                return .operationNotAllowed
            case .errorCodeInvalidEmail:
                return .invalidMail
            case .errorCodeUserDisabled:
                return .userDisabled
            case .errorCodeWrongPassword:
                return .wrongPassword
            default:
                let firebaseCommonError = RequestError.Firebase.match(error: error)
                return .firebaseCommon(error: firebaseCommonError)
            }
        }
    }
}

/*
 
 https://firebase.google.com/docs/auth/ios/errors
 
 ++++++ LOGIN ++++++++++
 
 FIRAuthErrorCodeOperationNotAllowed	Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.
 
 FIRAuthErrorCodeInvalidEmail	Indicates the email address is malformed.
 
 FIRAuthErrorCodeUserDisabled	Indicates the user's account is disabled.
 
 FIRAuthErrorCodeWrongPassword	Indicates the user attempted sign in with a wrong password.
 
 */
