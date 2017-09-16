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
    
    let profileItemsContents: [ProfileCellType] = [
            .name,
            .heart,
            .comment,
            .post,
            .separator,
            .logout
        ]
    
    var profileViewModel: ProfileViewModel!
    
    @IBOutlet weak var profileTableView: UITableView!
    override func viewDidLoad() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
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
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileCell
            cell.setup(with: item)
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = profileItemsContents[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        let navController = self.navigationController!
        
        switch item {
        case .separator:
            break
        case .name:

            let controller = profileViewModel.didTouchName()
            navController.pushViewController(controller, animated: true)

        case .heart:
            
            let controller = profileViewModel.didTouchHeart()
            navController.pushViewController(controller, animated: true)
            
        case .comment:
            
            let controller = profileViewModel.didTouchComment()
            navController.pushViewController(controller, animated: true)
            
        case .post:
            
            let controller = profileViewModel.didTouchPost()
            navController.pushViewController(controller, animated: true)
            
        case .logout:
            profileViewModel.didTouchLogout(completion: { (error) in
                if error != nil {
                    presentAlert(title: "erro no logout", message: error.debugDescription)
                }
            })
            break
            
        }
        


    }
    
}
