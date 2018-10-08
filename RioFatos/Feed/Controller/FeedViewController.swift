//
//  FeedViewController.swif
//  RioFatos
//
//  Created by Bruno Baring on 24/06/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import UIKit
import PullToRefresh

enum RefreshPosition {
    case top(GetablePost?)
    case bottom(GetablePost?)
    case initial
}

class FeedViewController: UICollectionViewController
{
    
    let reuseIdentifier = "postCell"
    @IBOutlet var feedCollectionView: UICollectionView!
    var feedPresenter = FeedPresenter()//(feedPostPresenter: [])
    let refresherTop = PullToRefresh(height: 20, position: .top)
    let refresherBottom = PullToRefresh(height: 20, position: .bottom)

    deinit {
    feedCollectionView.removePullToRefresh(feedCollectionView.topPullToRefresh!)
    feedCollectionView.removePullToRefresh(feedCollectionView.bottomPullToRefresh!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupProtocols()
        configRefresher()
        FirebaseService().logout { (joe) in
            print("asd")
        }
    }
    
    func setupProtocols()
    {
        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
        
//        self.startLoading()
        getFeedContent(at: nil) { (error) in
//            self.stopLoading()
            self.feedCollectionView.reloadData()
        }
    }
    
    func configRefresher() {
        feedCollectionView.addPullToRefresh(refresherTop) {
            self.getFeedContent(at: .top, completion: { (error) in
                DispatchQueue.main.async {
                    self.feedCollectionView.endRefreshing(at: .top)
                    self.feedCollectionView.reloadData()
                }
            })
        }
        feedCollectionView.addPullToRefresh(refresherBottom) {
            self.getFeedContent(at: .bottom, completion: { (error) in
                DispatchQueue.main.async {
                    self.feedCollectionView.endRefreshing(at: .bottom)
                    self.feedCollectionView.reloadData()
                }
            })
        }
    }

    func getFeedContent(at position: Position?, completion: @escaping (RequestError.Feed.ErrorType?) -> Void) {
        self.feedPresenter.getFeedContent(at: position) { error in
            guard error == nil else {
                completion(error)
                return
            }
            self.feedCollectionView.reloadData()
            switch position {
            case .top?:
                self.feedCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            case .bottom?:
                self.feedCollectionView.setContentOffset(CGPoint(x: 0, y: self.feedCollectionView.contentSize.height - self.feedCollectionView.bounds.size.height), animated: true)
            case .none:
                break
            }
            completion(error)
            return
        }
    }
    
}


extension FeedViewController
{
    
    
    func didHeart(feedPost: GetablePost, completion: @escaping (Bool) -> Void) {
        feedPresenter.didHeart(feedPost: feedPost) { (_error) in
            
            guard let error = _error else {
                completion(true)
                return
            }
            completion(false)
            switch error {
            default:
                self.presentAlert(title: "Ops", message: "Erro desconhecido")
            }
        }
    }
    
    
}

