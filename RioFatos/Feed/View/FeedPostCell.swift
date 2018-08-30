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
    @IBOutlet weak var commentView: CommentButtonView!
    @IBOutlet weak var detailsView: DetailsButtonView!
    @IBOutlet weak var shareView: ShareButtonView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    var feedPhotoCollectionView: FeedPhotoCollectionView! = nil
    
    var parent: FeedViewController! = nil
    var feedPost: GetablePost?

    
    func setup(feedPost: GetablePost, parent: FeedViewController)
    {
        self.feedPost = feedPost
        self.parent = parent
        setupProtocols()
        title.text = feedPost.title
        subtitle.text = feedPost.description
    }
    
    @IBAction func didTouchHeartButton(_ sender: Any) {
        guard let feedPost = self.feedPost else {
            return
        }
        parent.didHeart(feedPost: feedPost) { mustAnimate in
            self.heartView.turnAnimate(toState: mustAnimate)
        }
    }
    
    @IBAction func didTouchCommentButton(_ sender: Any) {
        self.commentView.turnAnimate(toState: true)
        if let commentController = UIStoryboard(name: "Comment", bundle: nil).instantiateViewController(withIdentifier: "CommentController") as? CommentController {
            parent.present(commentController, animated: true, completion: nil)
        }
    }
    
    @IBAction func didTouchDetailsButton(_ sender: Any) {
        self.detailsView.turnAnimate(toState: true)
    }
    
    @IBAction func didTouchShareButton(_ sender: Any) {
        guard let feedPost = self.feedPost else {
            return
        }
        share(feedPost: feedPost)
        self.shareView.turnAnimate(toState: true)
    }
    
    
    func setupProtocols()
    {
        guard let feedPost = self.feedPost else {
            return
        }
        
        feedPhotoCollectionView = FeedPhotoCollectionView(images: feedPost.images)
        photoCollectionView.delegate = feedPhotoCollectionView
        photoCollectionView.dataSource = feedPhotoCollectionView
        photoCollectionView.prefetchDataSource = feedPhotoCollectionView
        photoCollectionView.reloadData()
    }
    
    func share(feedPost: GetablePost) {

        let textToShare = [ feedPost.uid ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = parent.view
        
        activityViewController.excludedActivityTypes = [
            .saveToCameraRoll,
            .assignToContact,
            .postToFlickr,
            .postToVimeo,
            .openInIBooks
        ]
        
        parent.present(activityViewController, animated: true, completion: nil)

    }
}
