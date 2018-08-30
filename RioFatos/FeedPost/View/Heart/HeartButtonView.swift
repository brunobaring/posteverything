//
//  HeartButtonView.swift
//  RioFatos
//
//  Created by Bruno Baring on 24/08/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit

class HeartButtonView: FeedActionButtonView, FeedActionAnimatable {
    
}

extension HeartButtonView: FeedActionCountable {
    
    func setCounter(_ count: Int) {
        actionLabel.text = "\(count)"
    }
    
}
