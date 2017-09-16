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
    
    var loginViewModel: LoginViewModel!
    var myView: LoginView!
    
    override func viewDidLoad() {
        if let view = self.view as? LoginView {
            self.myView = view
        }
    }
    
    
    @IBAction func didTouchActionButton(_ sender: Any) {
        
        
        let user = User(uid: nil,
                        name: nil,
                        email: myView.identificationTextField.text!,
                        password: myView.passwordTextField.text!)
        
        loginViewModel.login(user) { (fireUser, fireError) in
            guard fireError == nil else {
                print("deu ruim", fireUser, "jabba", fireError)
                return
            }
        }
        
    }
    
    
}
