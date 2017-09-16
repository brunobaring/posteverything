//
//  LoginView.swift
//  RioFatos
//
//  Created by Bruno Baring on 13/09/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit

enum ButtonState {
    case loginOnTop
    case signupOnTop
    
    var actionButtonName: String {
        switch self {
        case .loginOnTop:
            return "Login"
        case .signupOnTop:
            return "Sign up"
        }
    }
    
    var changeStateButtonName: String {
        switch self {
        case .loginOnTop:
            return "Sign up"
        case .signupOnTop:
            return "Login"
        }
    }
}

class LoginView: UIView {
    @IBOutlet weak var usernameTextFieldHeightConstrain: NSLayoutConstraint!
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var identificationTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var changeStateButton: UIButton!
    @IBOutlet weak var actionButton: UIButton!
    var actionButtonState: ButtonState = .loginOnTop
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
    }
    
    @IBAction func didTouchChangeStateButton(_ sender: Any) {
        swapUserActionAnimation(withDuration: 0.3)
    }
    
    func swapUserActionAnimation(withDuration duration: TimeInterval) {

        actionButton.isUserInteractionEnabled = false
        changeStateButton.isUserInteractionEnabled = false

        UIView.animate(withDuration: duration, animations: {
            self.actionButton.titleEdgeInsets = UIEdgeInsetsMake(100.0, 0.0, 0.0, 0.0)
            self.changeStateButton.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 100.0, 0.0)
            self.layoutIfNeeded()
            
            switch self.actionButtonState {
            case .loginOnTop:
                self.actionButtonState = .signupOnTop
                let height = self.identificationTextField.frame.height
                self.usernameTextFieldHeightConstrain.constant = height
                self.layoutIfNeeded()
            case .signupOnTop:
                self.actionButtonState = .loginOnTop
                self.usernameTextFieldHeightConstrain.constant = 0
                self.layoutIfNeeded()
            }
            
            self.actionButton.setTitle(self.actionButtonState.actionButtonName, for: .normal)
            self.changeStateButton.setTitle(self.actionButtonState.changeStateButtonName, for: .normal)
            self.layoutIfNeeded()
            
            self.actionButton.titleLabel?.alpha = 0
            self.changeStateButton.titleLabel?.alpha = 0
            self.layoutIfNeeded()

        }, completion: { (finished) in
            
            UIView.animate(withDuration: duration, animations: { 
                self.layoutIfNeeded()
                self.actionButton.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
                self.changeStateButton.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
                self.layoutIfNeeded()
            }, completion: { (finished) in
                self.actionButton.isUserInteractionEnabled = true
                self.changeStateButton.isUserInteractionEnabled = true
            })
            
            UIView.animate(withDuration: duration/3, animations: {
                self.actionButton.titleLabel?.alpha = 1
                self.changeStateButton.titleLabel?.alpha = 1
                self.layoutIfNeeded()
            })
            
        })
    }
    
}
