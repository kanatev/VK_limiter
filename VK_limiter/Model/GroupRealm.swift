//
//  GroupRealm.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 04.08.2020.
//  Copyright © 2020 Aleksei Kanatev. All rights reserved.
//

import Foundation
import RealmSwift

class GroupRealm: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var screenName: String = ""
    @objc dynamic var photo100: String = ""
    
    convenience init(id: Int, name: String, screenName: String, photo100: String) {
        self.init()
        self.id = id
        self.name = name
        self.screenName = screenName
        self.photo100 = photo100
    }
}
