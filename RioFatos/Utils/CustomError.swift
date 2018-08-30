//
//  CustomError.swift
//  RioFatos
//
//  Created by Bruno Baring on 03/09/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation

enum CustomError {
    
    case userCouldNotBeParsed(title: String, message: String)
    case couldNotUpdateUsernameOnSignUp(title: String, message: String)
    case userMustBeLoggedToPost(title: String, message: String)
    case couldNotCreatePost(title: String, message: String)
    case couldNotLogin(title: String, message: String)
    case firebaseError(error: Error?)
}
