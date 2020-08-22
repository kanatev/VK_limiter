//
//  FriendCollectionVC.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 03/07/2019.
//  Copyright © 2019 Aleksei Kanatev. All rights reserved.
//

import UIKit

class FriendCollectionVC: UICollectionViewController {

//    var ourPerson: UserStruct?
//    var ourPerson: FriendStruct?
    var ourPerson: FriendRealm?


//    var photoArray: [UIImage] = []
    var photoArray: [CurrentFriendPhotoStruct] = []

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ourPerson!.firstName + " " + ourPerson!.lastName
//        print(ourPerson as Any)
    }

    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return photoArray.count
//        return (ourPerson?.photoArray!.count)!
        return photoArray.count
//        return 0

    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendsCollectionCell", for: indexPath) as? FriendsCollectionViewCell else {fatalError("Ячейка не может быть переиспользована")}
        
//        cell.imageView.image = ourPerson?.photoArray![indexPath.item]
        cell.imageView.image = photoArray[indexPath.item].photo
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoVC()
        vc.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        
//        vc.imageView?.image = ourPerson?.photoArray![indexPath.item]
//        vc.photoArray = ourPerson?.photoArray
        

        vc.modalPresentationStyle = .fullScreen
        vc.setNeedsStatusBarAppearanceUpdate()
        present(vc, animated: true, completion: nil)
    }
}
