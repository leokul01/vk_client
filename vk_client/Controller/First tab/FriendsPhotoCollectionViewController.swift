//
//  FriendsPhotoCollectionViewController.swift
//  vk_client
//
//  Created by Leonid Kulikov on 24/07/2018.
//  Copyright © 2018 Leonid Kulikov. All rights reserved.
//

import UIKit

class FriendsPhotoCollectionViewController: UICollectionViewController {

    var friend: Person?
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Calculating title for navigation bar
        if let barName = friend?.name {
            let barFirstName = barName.components(separatedBy: " ").first ?? "Friend's"
            title = "\(barFirstName)'s photos"
        }
        
        // Network
        guard let friend = friend else { return }
        photos = Array(VKService.shared.realm.objects(Photo.self).filter("owner = %@", friend))
        VKService.shared.getPhotosForFriend(friend) { [weak self] error in
            if let error = error {
                print("FriendsPhotoCollectionViewController: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self?.photos = Array(VKService.shared.realm.objects(Photo.self).filter("owner = %@", friend))
                self?.collectionView?.reloadData()
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsPhotoCell", for: indexPath) as! FriendsPhotoCollectionViewCell
    
        let photo = photos[indexPath.row]
        cell.setup(imageURLString: photo.imageString, indexPath: indexPath, collectionView: collectionView)
    
        return cell
    }

}

// MARK: CollectionView layout

extension FriendsPhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(
            width: (view.frame.width - 15)/2,
            height: (view.frame.width - 15)/2
        )
    }
    
}
