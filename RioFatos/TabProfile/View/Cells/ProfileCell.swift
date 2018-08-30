//
//  ProfileCell.swift
//  RioFatos
//
//  Created by Bruno Baring on 11/08/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func setup(with profileCellViewModel: ProfileCellViewModel) {
        iconImage.image = profileCellViewModel.image
        titleLabel.text = profileCellViewModel.label
        valueLabel.text = profileCellViewModel.content
    }
}


enum ProfileCellViewModelType {
    case name
    case hearts(uids: [String]?)
    case comments
    case posts(uids: [String]?)
    case logout
}

struct ProfileCellViewModel {
    let type: ProfileCellViewModelType
    let content: String?
    
    init(type: ProfileCellViewModelType, content: String) {
        self.type = type
        self.content = content
    }

    var image: UIImage? {
        switch type {
        case .name:
            return UIImage(named: "button_profile_profile")
        case .hearts:
            return UIImage(named: "button_heart_profile")
        case .comments:
            return UIImage(named: "button_comment_profile")
        case .posts:
            return UIImage(named: "button_details_profile")
        case .logout:
            return nil
        }
    }
    
    var label: String? {
        switch type {
        case .name:
            return "Name"
        case .hearts:
            return "Hearts"
        case .comments:
            return "Comments"
        case .posts:
            return "Posts"
        case .logout:
            return "Logout"
        }
    }
    
    var viewController: UIViewController? {
        switch type {
        case .name:
            return viewControllerFor(name: "ProfileName")
        case .hearts:
            return viewControllerFor(name: "ProfileHeart")
        case .comments:
            return viewControllerFor(name: "ProfileComment")
        case .posts:
            return viewControllerFor(name: "ProfilePost")
        case .logout:
            return nil
        }
    }
    
    fileprivate func viewControllerFor(name: String) -> UIViewController? {
        return UIStoryboard(name: name,bundle: nil).instantiateViewController(withIdentifier: name)
    }
}

enum ProfileCellType {
    case selectableCell(viewModel: ProfileCellViewModel)
    case separator
}

