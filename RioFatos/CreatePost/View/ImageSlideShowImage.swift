//
//  ImageSlideShowImage.swift
//  RioFatos
//
//  Created by Bruno Baring on 14/07/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import ImageSlideShowSwift

class ImageSlideShowImage: NSObject, ImageSlideShowProtocol
{
    fileprivate let id : String
    var image : UIImage
    
    init(id: Int, image: UIImage) {
        self.id = "\(id)"
        self.image = image
    }
    
    func slideIdentifier() -> String {
        return id
    }
    
    func image(completion: @escaping (UIImage?, Error?) -> Void) {
        completion(image, nil)
    }
}
