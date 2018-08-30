//
//  FeedError.swift
//  RioFatos
//
//  Created by Bruno Baring on 04/10/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import FirebaseAuth


extension FeedViewController {
    
    func handleError(_ error: RequestError.Feed.ErrorType) {
        switch error {
        case .unknown:
            self.presentAlert(title: "Ops", message: "Unknown Error")
        case let .firebaseCommon(error: erro):
            RequestError.Firebase.handleError(onController: self, error: erro)
        case .noDataAvailable:
            self.presentAlert(title: "Ops", message: "No Data Available")
        case .noDataForKey:
            self.presentAlert(title: "Ops", message: "No Data Available For Key")
        }
    }
    
}

extension RequestError {
    
    struct Feed {
        enum ErrorType: Error {
            
            case unknown(description: String)
            case firebaseCommon(error: RequestError.Firebase)
            
            case noDataAvailable
            case noDataForKey
            
        }
    }
}
