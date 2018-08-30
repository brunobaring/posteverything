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
        let firstController = profileNavController.viewControllers.first
        if Entities.shared.user == nil {
            if firstController is LoginController {
                return
            }
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as! LoginController
            controller.loginPresenter = LoginPresenter(profileManager: self)
            profileNavController.setViewControllers([controller], animated: false)
        }
        else {
            if let firstController = firstController as? ProfileController {
                firstController.fetchUser()
                return
            }
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
            controller.profilePresenter = ProfilePresenter(profileManager: self)
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
