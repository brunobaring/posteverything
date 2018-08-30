//
//  RequestErrors.swift
//  RioFatos
//
//  Created by Bruno Baring on 20/09/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import FirebaseAuth
import UIKit

class RequestError {}

extension RequestError {
    
    enum Firebase {

        case unknownCommon(error: Error)
        
        //common to all native methods in Firebase
        case networkError
        case userNotFound
        case userTokenExpired
        case tooManyRequests
        case invalidAPIKey
        case appNotAuthorized
        case keychainError
        case internalError
        
        //own particular errors
        case textErrorNotFound
        case keyNotFound
        case userDataNotFound
        case postDataNotFound
        case feedDataNotFound
        case userIsAlreadyLoggedOut
        case imageOrQualityNotFound
        case imageUrlNotAvailable

        static func match(text: String) -> Firebase {
            
            switch text {
            case "textErrorNotFound":
                return .textErrorNotFound
            case "keyNotFound":
                return .keyNotFound
            case "userDataNotFound":
                return .userDataNotFound
            case "postDataNotFound":
                return .postDataNotFound
            case "feedDataNotFound":
                return .feedDataNotFound
            case "userIsAlreadyLoggedOut":
                return .userIsAlreadyLoggedOut
            case "imageOrQualityNotFound":
                return .imageOrQualityNotFound
            case "imageUrlNotAvailable":
                return .imageUrlNotAvailable
            default:
                return .textErrorNotFound
            }
            
        }
        
        static func match(error: Error) -> Firebase {
            
         let fireError = FIRAuthErrorCode(rawValue: error._code)!
            
            switch fireError {
            case .errorCodeNetworkError:
                return .networkError
            case .errorCodeUserNotFound:
                return .userNotFound
            case .errorCodeUserTokenExpired:
                return .userTokenExpired
            case .errorCodeTooManyRequests:
                return .tooManyRequests
            case .errorCodeInvalidAPIKey:
                return .invalidAPIKey
            case .errorCodeAppNotAuthorized:
                return .appNotAuthorized
            case .errorCodeKeychainError:
                return .keychainError
            case .errorCodeInternalError:
                return .internalError
            default:
                return .unknownCommon(error: error)
            }
        }
        
        static func handleError(onController controller: UIViewController, error: Firebase) {
            switch error {
            case .networkError:
                controller.presentAlert(title: "Ops", message: "Network error. My guess is that you are offline")
            case .userNotFound:
                controller.presentAlert(title: "Ops", message: "User not found")
            case .userTokenExpired:
                controller.presentAlert(title: "Ops", message: "Token is expired")
            case .tooManyRequests:
                controller.presentAlert(title: "Ops", message: "You are flooding the server")
            case .invalidAPIKey:
                controller.presentAlert(title: "Ops", message: "APIKey is invalid")
            case .appNotAuthorized:
                controller.presentAlert(title: "Ops", message: "App is not authorized to use Firebase Authentication with the provided API Key")
            case .keychainError:
                controller.presentAlert(title: "Ops", message: "Keichain error")
            case .internalError:
                controller.presentAlert(title: "Ops", message: "Internal error from our service provider")

            case .textErrorNotFound:
                controller.presentAlert(title: "Ops", message: "Text Error Not Found")
            case .keyNotFound:
                controller.presentAlert(title: "Ops", message: "Key not Found")
            case .userDataNotFound:
                controller.presentAlert(title: "Ops", message: "User Data Not Found")
            case .postDataNotFound:
                controller.presentAlert(title: "Ops", message: "Post Data Not Found")
            case .feedDataNotFound:
                controller.presentAlert(title: "Ops", message: "Feed Data Not Found")
            case .userIsAlreadyLoggedOut:
                controller.presentAlert(title: "Ops", message: "User is already Logged Out")
            case .imageOrQualityNotFound:
                controller.presentAlert(title: "Ops", message: "Image or quality not found")
            case .imageUrlNotAvailable:
                controller.presentAlert(title: "Ops", message: "Image url not available")
            
            case let .unknownCommon(error: error):
                controller.presentAlert(title: "Ops", message: error.localizedDescription)
            }
        }
    }
}

/*
 
 
 
 ++++++ COMMON TO ALL METHODS ++++++++++
 
 FIRAuthErrorCodeNetworkError    Indicates a network error occurred during the operation.
 
 FIRAuthErrorCodeUserNotFound    Indicates the user account was not found. This could happen if the user account has been deleted.
 
 FIRAuthErrorCodeUserTokenExpired    Indicates the current user’s token has expired, for example, the user may have changed account password on another device. You must prompt the user to sign in again on this device.
 
 FIRAuthErrorCodeTooManyRequests    Indicates that the request has been blocked after an abnormal number of requests have been made from the caller device to the Firebase Authentication servers. Retry again after some time.
 
 FIRAuthErrorCodeInvalidAPIKey    Indicates the application has been configured with an invalid API key.
 
 FIRAuthErrorCodeAppNotAuthorized    Indicates the App is not authorized to use Firebase Authentication with the provided API Key. go to the Google API Console and check under the credentials tab that the API key you are using has your application’s bundle ID whitelisted.
 
 FIRAuthErrorCodeKeychainError    Indicates an error occurred when accessing the keychain. The NSLocalizedFailureReasonErrorKey and NSUnderlyingErrorKey fields in the NSError.userInfo dictionary will contain more information about the error encountered.
 
 FIRAuthErrorCodeInternalError    Indicates an internal error occurred. Please report the error with the entire NSError object.
 
 */
