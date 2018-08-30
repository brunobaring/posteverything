//
//  Heart.swift
//  RioFatos
//
//  Created by Bruno Baring on 24/06/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit

struct Heart
{
    
    var counter: Int
    var didHeart: Bool
    
    init?(dict: NSDictionary){
        guard let counter = dict["counter"] as? Int,
            let didHeart = dict["didHeart"] as? Bool else {
                return nil
        }
        
        self.init(counter: counter,
                  didHeart: didHeart)
    }
    
    init(counter: Int, didHeart: Bool) {
        self.counter = counter
        self.didHeart = didHeart
    }
    
}
