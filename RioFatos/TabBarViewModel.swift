//
//  TabBarViewModel.swift
//  RioFatos
//
//  Created by Bruno Baring on 03/09/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarViewModel {
    
    func mustShowCreatePost() -> Bool {
        return MainService.sharedInstance.user != nil
    }
    
}
