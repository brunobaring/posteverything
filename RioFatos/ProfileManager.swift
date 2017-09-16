//
//  ProfileManager.swift
//  RioFatos
//
//  Created by Bruno Baring on 31/08/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit

class ProfileManager {
    
    let profileNavController: ProfileNavigationController
    
    init(_ profileNavController: ProfileNavigationController) {
        self.profileNavController = profileNavController
    }
    
    func setProperlyRootViewController() {
        if Entities.shared.user == nil {
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as! LoginController
            controller.loginViewModel = LoginViewModel(profileManager: self)
            profileNavController.setViewControllers([controller], animated: false)
        }
        else if Entities.shared.user != nil {
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
            controller.profileViewModel = ProfileViewModel(user: Entities.shared.user, profileManager: self)
            profileNavController.setViewControllers([controller], animated: false)
        }
    }
    
    func didLogout() {
        setProperlyRootViewController()
    }
    
    func didLogin() {
        setProperlyRootViewController()
    }
    
}
