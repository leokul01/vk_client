//
//  FriendsListTableViewCell.swift
//  vk_client
//
//  Created by Leonid Kulikov on 23/07/2018.
//  Copyright © 2018 Leonid Kulikov. All rights reserved.
//

import UIKit

class FriendsListTableViewCell: UITableViewCell {

    @IBOutlet weak var friendsImageView: UIImageView!
    @IBOutlet weak var friendsNameLabel: UILabel!

    func setup(person: Person, indexPath: IndexPath, tableView: UITableView) {
        friendsNameLabel.text = person.name
        
        setImageToView(person: person, indexPath: indexPath, tableView: tableView)
        
        // Customization
        friendsImageView.layer.cornerRadius = 20
    }
    
    func setImageToView(person: Person, indexPath: IndexPath, tableView: UITableView) {
        let getCacheImage = GetCacheImage(url: person.profileImageURLString)
        let setImageToRow = SetImageToRowWithFriendCell(cell: self, indexPath: indexPath, tableView: tableView)
        setImageToRow.addDependency(getCacheImage)
        VKService.shared.networkQueue.addOperation(getCacheImage)
        OperationQueue.main.addOperation(setImageToRow)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        friendsImageView.image = nil
    }
}
