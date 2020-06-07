//
//  UserStructAPI.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 03.06.2020.
//  Copyright © 2020 Aleksei Kanatev. All rights reserved.
//

import Foundation
import UIKit

struct UserStructAPI: CustomStringConvertible {
    var description: String {
        return "\(first_name) \(last_name)"
    }
    
    let first_name: String
    let last_name: String

    init(name: String, lastName: String){
        self.first_name = name
        self.last_name = lastName
    }
}
