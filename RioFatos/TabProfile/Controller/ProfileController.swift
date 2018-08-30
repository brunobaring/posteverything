//
//  ProfileController.swift
//  RioFatos
//
//  Created by Bruno Baring on 11/08/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit


class ProfileController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    var profileItemsContents: [ProfileCellType] = []
    
    var profilePresenter: ProfilePresenter!
    
    @IBOutlet weak var profileTableView: UITableView!
    override func viewDidLoad() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        fetchUser()
    }
    
    func fetchUser() {
        
        guard let uid = Entities.shared.user?.uid else {
            return
        }
        
//        self.startLoading()
        profilePresenter.fetchUser(withUid: uid) { profileItemsContents, error in
//            self.stopLoading()
            
            if let error = error {
                self.handleError(error)
            }
            
            guard let user = Entities.shared.user else {
                return
            }
            
            guard let profileItemsContents = profileItemsContents else {
                return
            }
            
            self.profileItemsContents = profileItemsContents
            self.profileTableView.reloadData()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileItemsContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = profileItemsContents[indexPath.row]
        
        switch item {
        case .separator:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Separator")!
            cell.selectionStyle = .none
            return cell
        case let .selectableCell(profileCellViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileCell
            cell.setup(with: profileCellViewModel)
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        let item = profileItemsContents[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        
        switch item {
        case .separator:
            break
        case let .selectableCell(profileCellViewModel):
            profilePresenter.didTouchProfileCell(profileCellViewModel: profileCellViewModel)
        }
    }
}
