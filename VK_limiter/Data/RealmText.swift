//
//  RealmText.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 01.08.2020.
//  Copyright © 2020 Aleksei Kanatev. All rights reserved.
//

import Foundation
import RealmSwift

class RealmText: Object {
    @objc dynamic var realmText: String = "default"
    
    convenience init(realmText: String) {
        self.init()
        self.realmText = realmText
    }
}

