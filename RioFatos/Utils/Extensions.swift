//
//  Extensions.swift
//  RioFatos
//
//  Created by Bruno Baring on 24/06/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func setRootViewController(withId sbId: String, inStoryboard sbName: String) {
        let controller = UIStoryboard(name: sbName, bundle: nil).instantiateViewController(withIdentifier: sbId)
        self.setViewControllers([controller], animated: false)
    }

}

extension UIViewController {
    
    func presentAlert(title: String, message : String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction) in print("Youve pressed OK Button")
        }
        alertController.addAction(OKAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func getController(withId sbId: String, inStoryboard sbName: String) -> UIViewController {
        return UIStoryboard(name: sbName, bundle: nil).instantiateViewController(withIdentifier: sbId)
    }
    
}

extension Double {
    
    func formattedForFirebaseIndex() -> String {
        return String(format: "%.2f", self).replacingOccurrences(of: ".", with: "")
    }
    
}
