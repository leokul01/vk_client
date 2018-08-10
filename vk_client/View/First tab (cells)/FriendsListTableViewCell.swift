//
//  FriendsListTableViewCell.swift
//  vk_client
//
//  Created by Leonid Kulikov on 23/07/2018.
//  Copyright © 2018 Leonid Kulikov. All rights reserved.
//

import UIKit
//import Kingfisher

class FriendsListTableViewCell: UITableViewCell {

    @IBOutlet weak var friendsImageView: UIImageView!
    @IBOutlet weak var friendsNameLabel: UILabel!

    func setup(person: Person, indexPath: IndexPath, tableView: UITableView, queue: OperationQueue) {
        self.friendsNameLabel.text = person.name
        
        //self.friendsImageView.kf.setImage(with: URL(string: person.profileImageURLString))
        let getCacheImage = GetCacheImage(url: person.profileImageURLString)
        let setImageToRow = SetImageToRowWithFriendCell(cell: self, indexPath: indexPath, tableView: tableView)
        setImageToRow.addDependency(getCacheImage)
        queue.addOperation(getCacheImage)
        OperationQueue.main.addOperation(setImageToRow)
        
        // Customization
        self.friendsImageView.layer.cornerRadius = 20
        self.friendsImageView.clipsToBounds = true
    }
}
