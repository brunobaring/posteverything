//
//  ImagePickerProtocol.swift
//  RioFatos
//
//  Created by Bruno Baring on 13/07/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation


protocol MyImagePickerDelegate
{
    func didTouchImagePickerAddButton()
    func updatePhotoCollectionView()
    func didTouchPhoto(onIndex index: Int)
}
