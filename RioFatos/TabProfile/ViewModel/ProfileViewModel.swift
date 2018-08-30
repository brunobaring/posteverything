//
//  ProfilePresenter.swift
//  RioFatos
//
//  Created by Bruno Baring on 31/08/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit

class ProfilePresenter {
    
    enum ProfileItemScreenName: String  {
        case name = "ProfileName"
        case heart = "ProfileHeart"
        case comment = "ProfileComment"
        case post = "ProfilePost"
        case logout = "LoginController"
    }
    
    var profileManager: ProfileManager
    var service = ProfileService()
    
    init(profileManager: ProfileManager) {
        self.profileManager = profileManager
    }
    
    func fetchUser(withUid uid: String, completion: @escaping ([ProfileCellType]?, RequestError.Profile.ErrorType?) -> Void) {
        service.fetchUser(withUid: uid) { (user, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let user = user else {
                completion(nil, .fetchUser)
                return
            }
            
            Entities.shared.user = user
            
            var profileItemsContents: [ProfileCellType] = []
            
            if let name = user.name {
                let viewModel =                     ProfileCellViewModel(type: .name, content: name)
                let profileCellType =  ProfileCellType.selectableCell(viewModel: viewModel)
                profileItemsContents.append(profileCellType)
            }
            
            let heartViewModel =                     ProfileCellViewModel(type: .hearts(uids: user.hearted), content: String(user.hearted?.count ?? 0))
            let heartProfileCellType = ProfileCellType.selectableCell(viewModel: heartViewModel)
            profileItemsContents.append(heartProfileCellType)
            
            let commentViewModel = ProfileCellViewModel(type: .comments, content: "xx")
            let commentProfileCellType = ProfileCellType.selectableCell(viewModel: commentViewModel)
            profileItemsContents.append(commentProfileCellType)
            
            let viewModel = ProfileCellViewModel(type: .posts(uids: user.posts), content: String(user.posts?.count ?? 0))
            let profileCellType = ProfileCellType.selectableCell(viewModel: viewModel)
            profileItemsContents.append(profileCellType)
            
            profileItemsContents.append(.separator)
            
            let logoutViewModel = ProfileCellViewModel(type: .logout, content: "")
            let logoutProfileCellType = ProfileCellType.selectableCell(viewModel: logoutViewModel)
            profileItemsContents.append(logoutProfileCellType)
            
            completion(profileItemsContents, nil)

        }
    }
    
    func didTouchLogout(completion: (RequestError.Login.ErrorType?) -> Void) {
        service.logout { (error) in
            if error == nil {
                Entities.shared.user = nil
                profileManager.didLogout()
            }
            completion(error)
        }
    }
    
    func didTouchProfileCell(profileCellViewModel: ProfileCellViewModel) {
        switch profileCellViewModel.type {
        case .name:
            didTouchName(profileCellViewModel)
        case .hearts:
            didTouchHeart(profileCellViewModel)
        case .comments:
            didTouchComment(profileCellViewModel)
        case .posts:
            didTouchPost(profileCellViewModel)
        case .logout:
            didTouchLogout(completion: { (error) in
                if let error = error {
                    profileManager.profileNavController.presentAlert(title: "erro no logout", message: error.localizedDescription)
                }
            })
        }
    }
    
    func didTouchName(_ model: ProfileCellViewModel) -> Void {
        guard let controller = model.viewController else {
            return
        }
        profileManager.profileNavController.pushViewController(controller, animated: true)
    }
    
    func didTouchHeart(_ model: ProfileCellViewModel) -> Void {
        guard let controller = model.viewController else {
            return
        }
        profileManager.profileNavController.pushViewController(controller, animated: true)
    }
    func didTouchComment(_ model: ProfileCellViewModel) -> Void {
        guard let controller = model.viewController else {
            return
        }
        profileManager.profileNavController.pushViewController(controller, animated: true)
    }
    func didTouchPost(_ model: ProfileCellViewModel) -> Void {
        guard let controller = model.viewController else {
            return
        }
        profileManager.profileNavController.pushViewController(controller, animated: true)
    }


}
