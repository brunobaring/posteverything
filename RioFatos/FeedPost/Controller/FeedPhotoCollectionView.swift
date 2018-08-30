//
//  FeedPhotoProtocols.swift
//  RioFatos
//
//  Created by Bruno Baring on 09/07/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class FeedPhotoCollectionView: NSObject
{
    fileprivate let reuseIdentifier = "feedPhotoCell"
    var imagesURLs: [URL]
    
    init(images: [PostImage]) {
        self.imagesURLs = images.flatMap({ (postImages) in
            guard let urlString = postImages.url else {
                return nil
            }
            return URL(string: urlString)
        })
    }
}


extension FeedPhotoCollectionView: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let layout: UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        return CGSize(width: UIScreen.main.bounds.width,
                      height: layout.itemSize.height)
    }
}


extension FeedPhotoCollectionView: UICollectionViewDelegate
{
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as! FeedPhotoCell).photo.kf.cancelDownloadTask()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        _ = (cell as! FeedPhotoCell).photo.kf.setImage(with: imagesURLs[indexPath.row],
                                                                    placeholder: nil,
                                                                    options: [.transition(ImageTransition.fade(1))],
                                                                    progressBlock: { receivedSize, totalSize in
                                                                        print("\(indexPath.row + 1): \(receivedSize)/\(totalSize)")
        },
                                                                    completionHandler: { image, error, cacheType, imageURL in
                                                                        print("\(indexPath.row + 1): Finished")
        })
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
}


extension FeedPhotoCollectionView: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return imagesURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedPhotoCell
        cell.photo.kf.indicatorType = .activity
        return cell
    }
    
}

extension FeedPhotoCollectionView: UICollectionViewDataSourcePrefetching
{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        ImagePrefetcher(urls: imagesURLs).start()
    }
    
    
}
