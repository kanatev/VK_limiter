//
//  FriendsDataSingleton.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 06.06.2020.
//  Copyright © 2020 Aleksei Kanatev. All rights reserved.
//

import Foundation

class FriendsDataSingleton {
    private init() {}
    public static let shared = FriendsDataSingleton()
    
    var friendsArray: [FriendStruct]?
}
