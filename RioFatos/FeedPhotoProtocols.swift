//
//  FeedPhotoProtocols.swift
//  RioFatos
//
//  Created by Bruno Baring on 09/07/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit

class FeedPhotoProtocols: NSObject
{
    fileprivate let reuseIdentifier = "feedPhotoCell"
}


extension FeedPhotoProtocols: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let layout: UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        return CGSize(width: UIScreen.main.bounds.width,
                      height: layout.itemSize.height)
    }
}


extension FeedPhotoProtocols: UICollectionViewDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
}


extension FeedPhotoProtocols: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
    
}
