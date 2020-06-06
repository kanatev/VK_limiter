//
//  FriendStruct.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 06.06.2020.
//  Copyright © 2020 Aleksei Kanatev. All rights reserved.
//

import Foundation
import UIKit

struct FriendStruct: CustomStringConvertible {
    var description: String {
        return "\(first_name) \(last_name) \(id)"
    }
    
    let id: Int
    let first_name: String
    let last_name: String
    let photo100: UIImage
    
    init(id: Int, name: String, lastName: String, photo100: UIImage){
        self.id = id
        self.first_name = name
        self.last_name = lastName
        self.photo100 = photo100
    }
}
