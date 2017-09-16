//
//  Environment.swift
//  RioFatos
//
//  Created by Bruno Baring on 21/07/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation

class Environment
{
    
    static var sharedInstance = Environment()
    private init() {}

    var titleCharLeftQtyMax = 10
    var titleCharLeftQtyText = " characters left"
    var descriptionCharLeftQtyMax = 10
    var descriptionCharLeftQtyText = " characters left"
    var sendButtonText = "Send"
    
    
    func setInitialConfig()
    {
        MainService.sharedInstance.setInitialConfig()
    }
}
