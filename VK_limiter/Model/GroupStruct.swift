//
//  Group.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 09/07/2019.
//  Copyright © 2019 Aleksei Kanatev. All rights reserved.
//

import Foundation
import UIKit

struct GroupStruct: Equatable {
    
    let groupName: String
    let groupAvatar: UIImage?
    
    init(groupName: String,
         groupAvatar: UIImage? = nil) {
        
        self.groupName = groupName
        self.groupAvatar = groupAvatar
    }
    
    static func createGroupsArray () -> [GroupStruct] {
        return groupsArray
    }
    
    static func createAddGroupsArray() -> [GroupStruct] {
        return allGroupsArray
    }
    
}

