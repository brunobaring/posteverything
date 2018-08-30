//
//  FeedCollectionViewDelegates.swift
//  RioFatos
//
//  Created by Bruno Baring on 09/07/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit

extension FeedViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let layout: UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        return CGSize(width: UIScreen.main.bounds.width,
                      height: layout.itemSize.height)
    }
}

extension FeedViewController
{
    override func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return spinner.loaded ? 0 : 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return feedPresenter.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedPostCell
        cell.setup(feedPost: feedPresenter.getPost(withIndex: indexPath.row), parent: self)
        return cell
    }
}
