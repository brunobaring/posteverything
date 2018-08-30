//
//  CreatePostPhotoProtocols.swift
//  RioFatos
//
//  Created by Bruno Baring on 13/07/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit
import ImagePicker
import ImageSlideShowSwift

class CreatePostPhotoProtocols: NSObject
{
    
    var reuseIdentifier = "addPhotoButtonCell"
    var thumbnailImages = [ImageSlideShowImage]()
    var delegate : CreatePostController! = nil
    
}


extension CreatePostPhotoProtocols: UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 111 * pw, height: 104 * ph)
    }
    
}


extension CreatePostPhotoProtocols: UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}


extension CreatePostPhotoProtocols: UICollectionViewDelegate
{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addPhotoButtonCell", for: indexPath)
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoThumbnailCell", for: indexPath) as! PhotoThumbnailCell
            cell.thumbnail.image = thumbnailImages[indexPath.item - 1].image
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 + thumbnailImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0
        {
            delegate.didTouchImagePickerAddButton()
        }
        else
        {
            delegate.didTouchPhoto(onIndex: indexPath.item)
        }
    }
    
}


extension CreatePostPhotoProtocols: ImagePickerDelegate
{
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        thumbnailImages = [ImageSlideShowImage]()
        for i in 0..<images.count
        {
            thumbnailImages.append(ImageSlideShowImage(id: i, image: images[i]))
        }
        delegate.updatePhotoCollectionView()
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }
    
}
