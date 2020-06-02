//
//  User.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 09/07/2019.
//  Copyright © 2019 Aleksei Kanatev. All rights reserved.
//

import Foundation
import UIKit

struct UserStruct {
    
    let name: String
    let avatar: UIImage?
    let photoArray: [UIImage]?
    
    init(name: String,
        avatar: UIImage? = nil,
        photoArray: [UIImage]? = nil) {
        
        self.name = name
        self.avatar = avatar
        self.photoArray = photoArray
    }
    
    static func createFriendsArray () -> [UserStruct] {
        return friendsArray
    }
    
}

