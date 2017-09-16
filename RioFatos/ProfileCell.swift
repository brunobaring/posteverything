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
    
    func setup(with content: ProfileCellType) {
        switch content {
        case .name:
            setContent(
                imageName: "button_profile_profile",
                title: "Name",
                value: "Famoso Jabba"
            )
        case .heart:
            setContent(
                imageName: "button_heart_profile",
                title: "Hearts",
                value: "23"
            )
        case .comment:
            setContent(
                imageName: "button_comment_profile",
                title: "Comments",
                value: "33"
            )
        case .post:
            setContent(
                imageName: "button_details_profile",
                title: "Posts",
                value: "2"
            )
        case .logout:
            setContent(
                imageName: "",
                title: "logout",
                value: ""
            )
        default:
            setContent(
                imageName: "",
                title: "Unknown Option",
                value: ""
            )
        }
    }
    
    func setContent(imageName: String, title: String, value: String) {
        iconImage.image = UIImage(named: imageName)
        titleLabel.text = title
        valueLabel.text = value
    }
}


enum ProfileCellType {
    case name
    case heart
    case comment
    case post
    case separator
    case logout
}

