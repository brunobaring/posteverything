//
//  TabBarController.swift
//  RioFatos
//
//  Created by Bruno Baring on 24/06/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate
{
    
    @IBOutlet var buttonView: UIView!
    var mainTabBarViewModel = MainTabBarViewModel()
    
    override func viewDidLoad() {
        Environment.sharedInstance.setInitialConfig()
        setupDoPostButton()
        self.delegate = self
    }
    
    func setupDoPostButton()
    {
        buttonView.frame.size = CGSize(width: pw * 58, height: ph * 58)
        buttonView.frame.origin.y = tabBar.frame.height - buttonView.frame.height
        buttonView.center.x = tabBar.center.x
        tabBar.addSubview(buttonView)
    }
    
    @IBAction func didTouchPostButton(_ sender: Any)
    {
        if !mainTabBarViewModel.mustShowCreatePost() {
            presentAlert(title: "Ops", message: "User must be logged to Create Post")
        }
        
        let storyboard = UIStoryboard(name: "CreatePost", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CreatePost")
        
        present(controller, animated: true, completion: nil)

    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is ProfileNavigationController {
            let profileManager = ProfileManager(viewController as! ProfileNavigationController)
            profileManager.setProperlyRootViewController()
        }
    }
    
    
}
