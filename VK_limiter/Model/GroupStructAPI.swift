//
//  GroupStructAPI.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 04.06.2020.
//  Copyright © 2020 Aleksei Kanatev. All rights reserved.
//

import Foundation
import UIKit

struct GroupStructAPI: CustomStringConvertible {
    var description: String {
        return "\(name)"
    }
    
    
    let id: Int
    let name: String
    let screenName: String
    let photo50: String
    
    init (id: Int, name: String, screenName: String, photo50: String) {
        self.id = id
        self.name = name
        self.screenName = screenName
        self.photo50 = photo50
    }
    
}
