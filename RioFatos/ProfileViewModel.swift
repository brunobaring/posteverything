//
//  ProfileViewModel.swift
//  RioFatos
//
//  Created by Bruno Baring on 31/08/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewModel {
    
    enum ProfileItemScreenName: String  {
        case name = "ProfileName"
        case heart = "ProfileHeart"
        case comment = "ProfileComment"
        case post = "ProfilePost"
        case logout = "LoginController"
    }
    
    var profileManager: ProfileManager
    var user: User?
    
    init(user: User?, profileManager: ProfileManager) {
        self.user = user
        self.profileManager = profileManager
    }
    
    func didTouchLogout(completion: (Error?) -> Void) {
        MainService.sharedInstance.logout { (error) in
            if error == nil {
                profileManager.didLogout()
            }
            completion(error)
        }
    }
    
    func didTouchName() -> UIViewController {
        return getMenuController(.name)
    }
    func didTouchHeart() -> UIViewController {
        return getMenuController(.heart)
    }
    func didTouchComment() -> UIViewController {
        return getMenuController(.comment)
    }
    func didTouchPost() -> UIViewController {
        return getMenuController(.post)
    }
    
    func getMenuController(_ item: ProfileItemScreenName) -> UIViewController {
        
        return UIStoryboard(
            name: item.rawValue,
            bundle: nil).instantiateViewController(withIdentifier: item.rawValue)
    }
    
    func getController(withId sbId: String, inStoryboard sbName: String) -> UIViewController {
        return UIStoryboard(name: sbName, bundle: nil).instantiateViewController(withIdentifier: sbId)
    }

}
