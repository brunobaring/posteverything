//
//  LoginController.swift
//  RioFatos
//
//  Created by Bruno Baring on 11/08/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LoginController: UIViewController
{
    
    var loginPresenter: LoginPresenter!
    var myView: LoginView!
    
    override func viewDidLoad() {
        if let view = self.view as? LoginView {
            self.myView = view
        }
    }
    
    @IBAction func didTouchActionButton(_ sender: Any) {
        
        let name = myView.nameTextField.text
        let identification = myView.identificationTextField.text
        let password = myView.passwordTextField.text
        
        switch myView.actionButtonState {
        case .loginOnTop:
            self.startLoading()
            loginPresenter.login(withIdentification: identification, _password: password) { error in
                self.stopLoading()
                if let error = error {
                    self.handleError(error)
                    return
                }
            }
        case .signupOnTop:
            self.startLoading()
            loginPresenter.signUp(
                withIdentification: myView.identificationTextField.text!,
                password: myView.passwordTextField.text!,
                name: myView.nameTextField.text!,
                completion: { error in
                    self.stopLoading()
                    
                    if let error = error {
                        self.handleError(error)
                        return
                    }
            })
        }
        
    }
    
}
