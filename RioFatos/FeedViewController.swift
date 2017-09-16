//
//  FeedViewController.swif
//  RioFatos
//
//  Created by Bruno Baring on 24/06/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import UIKit

class FeedViewController: UICollectionViewController
{

    @IBOutlet var feedCollectionView: UICollectionView!
    var feedVM = FeedVM(feedPostVM: [])
    var feedCollectionViewDelegates : FeedCollectionViewDelegates! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupProtocols()

    }
    
    func setupProtocols()
    {
        feedCollectionViewDelegates = FeedCollectionViewDelegates()
        feedCollectionView.delegate = feedCollectionViewDelegates
        feedCollectionView.dataSource = feedCollectionViewDelegates

        feedCollectionViewDelegates.delegate = self
        getFeedContent()

        

        //        feedCollectionView.reloadData()
        
//        feedVM?.delegate = self
    }
    
}


extension FeedViewController: FeedPaginationDelegate
{
    func getFeedContent()
    {
        self.feedVM.getFeedContent() { error in
            guard error == nil else { return }
            self.feedCollectionView.reloadData()
        }
    }
    
    func feedPostPageForward()
    {
        
    }
    
    func feedPostBackward()
    {
        
    }
}


extension FeedViewController: HeartDelegate
{

    func didHeart(feedPost: Post, completion: @escaping (Bool) -> Void) {
        feedVM.didHeart(feedPost: feedPost) { aa in
            completion(true)
        }
    }
    
    func didHeart(feedPost: Post)
    {
        feedVM.didHeart(feedPost: feedPost)
    }
    
    func didHeart(feedPost: Post, withError error: String)
    {
        print(error)
    }
    
}

