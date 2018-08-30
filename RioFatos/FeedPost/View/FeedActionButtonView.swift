//
//  FeedActionButtonView.swift
//  RioFatos
//
//  Created by Bruno Baring on 15/09/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit


class FeedActionButtonView: UIView {
    
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var actionImageView: UIImageView!
    @IBOutlet weak var actionButton: UIButton!
    
    @IBOutlet weak var actionImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var actionImageViewWidth: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        print("setup")
    }
    
}



extension FeedActionAnimatable where Self: FeedActionButtonView {
    
    func turnAnimate(toState state: Bool) {
        actionButton.isUserInteractionEnabled = false
        var height = actionImageViewHeight.constant
        
        print("turnAnimated toState \(state)")
        
        UIView.animate(withDuration: 0.5, animations: {
            self.actionImageViewHeight.constant = height * 1.3
            self.actionImageViewWidth.constant = height * 1.3
            self.layoutIfNeeded()
        }, completion: { (finished) in
            print("cresceu")
            UIView.animate(withDuration: 0.5, animations: {
                self.actionImageViewHeight.constant = height
                self.actionImageViewWidth.constant = height
                self.actionImageView.tintColor = self.getColor(forState: state)
                self.layoutIfNeeded()
            }, completion: { (finished) in
                print("Done")
                self.actionButton.isUserInteractionEnabled = true
            })
        })
        
    }
    
    func getColor(forState state: Bool) -> UIColor {
        
        switch state {
        case true:
            return DColor.getColor(.blue)
        case false:
            return DColor.getColor(.error)
        }
    }
    
}


