//
//  FeedPaginationDelegate.swift
//  RioFatos
//
//  Created by Bruno Baring on 23/07/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation

protocol FeedPaginationDelegate
{
    func getFeedContent()
    func feedPostPageForward()
    func feedPostBackward()
}
