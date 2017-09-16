//
//  FeedCollectionViewDelegates.swift
//  RioFatos
//
//  Created by Bruno Baring on 09/07/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit

class FeedCollectionViewDelegates: NSObject
{
    fileprivate let reuseIdentifier = "postCell"
    var delegate : FeedViewController! = nil
}


extension FeedCollectionViewDelegates: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let layout: UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        return CGSize(width: UIScreen.main.bounds.width,
                      height: layout.itemSize.height)
    }
}


extension FeedCollectionViewDelegates: UICollectionViewDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
}


extension FeedCollectionViewDelegates: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return delegate!.feedVM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedPostCell
        cell.setup(feedPost: delegate!.feedVM.getPost(withIndex: indexPath.row), parent: delegate)
        return cell
    }
}
