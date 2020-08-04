//
//  FriendPhotoRealm.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 04.08.2020.
//  Copyright © 2020 Aleksei Kanatev. All rights reserved.
//

import Foundation
import RealmSwift

class FriendPhotoRealm: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var photo: String = ""
    
    convenience init(id: Int, photo: String) {
        self.init()
        self.id = id
        self.photo = photo
    }
}
