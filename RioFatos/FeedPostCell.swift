//
//  FeedPostCell.swift
//  RioFatos
//
//  Created by Bruno Baring on 09/07/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit

class FeedPostCell: UICollectionViewCell
{
    
    @IBOutlet weak var heartView: HeartButtonView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    var feedPhotoProtocols: FeedPhotoProtocols! = nil
    
    var apagar = true
    var parent: FeedViewController! = nil
    var feedPost: Post?

    
    func setup(feedPost: Post, parent: FeedViewController)
    {
        self.feedPost = feedPost
        self.parent = parent
        setupProtocols()
        title.text = feedPost.title
        subtitle.text = feedPost.description
    }
    
    @IBAction func didTouchHeartButton(_ sender: Any) {
        parent.didHeart(feedPost: self.feedPost!) { mustAnimate in
            self.apagar = !self.apagar
            self.heartView.turnAnimate(toState: mustAnimate)
        }
    }
    
    @IBAction func didTouchCommentButton(_ sender: Any) {
    }
    
    @IBAction func didTouchDetailsButton(_ sender: Any) {
    }
    
    @IBAction func didTouchShareButton(_ sender: Any) {
    }
    
    
    func setupProtocols()
    {
        feedPhotoProtocols = FeedPhotoProtocols()
        photoCollectionView.delegate = feedPhotoProtocols
        photoCollectionView.dataSource = feedPhotoProtocols
        photoCollectionView.reloadData()
    }
    
}
