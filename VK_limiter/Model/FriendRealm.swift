//
//  FriendRealm.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 01.08.2020.
//  Copyright © 2020 Aleksei Kanatev. All rights reserved.
//

import Foundation
import RealmSwift

class FriendRealm: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var photo100: String = ""
    @objc dynamic var avaRealm: String = ""
    
//    override static func primaryKey() -> String? {
//        return "id"
//    }
    
    convenience init(id: Int, firstName: String, lastName: String, photo100: String, avaRealm: String) {
        self.init()
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.photo100 = photo100
        self.avaRealm = avaRealm
    }
}
