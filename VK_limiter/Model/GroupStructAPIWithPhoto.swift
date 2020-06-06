//
//  GroupStructAPIWithPhoto.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 06.06.2020.
//  Copyright © 2020 Aleksei Kanatev. All rights reserved.
//

import Foundation
import UIKit

struct GroupStructAPIWithPhoto: CustomStringConvertible {
    var description: String {
        return "\(name)"
    }
    
    
    let id: Int
    let name: String
    let screenName: String
    let photo100: UIImage
    
    init (id: Int, name: String, screenName: String, photo100: UIImage) {
        self.id = id
        self.name = name
        self.screenName = screenName
        self.photo100 = photo100
    }
    
}
