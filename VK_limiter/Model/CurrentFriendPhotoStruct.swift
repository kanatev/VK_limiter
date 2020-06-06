//
//  CurrentFriendPhotoStruct.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 06.06.2020.
//  Copyright © 2020 Aleksei Kanatev. All rights reserved.
//

import Foundation
import UIKit

struct CurrentFriendPhotoStruct: CustomStringConvertible {
    var description: String {
        return "id photo: \(id)"
    }
    

    let id: Int
    let photo: UIImage
    
    init(id: Int, photo: UIImage){
        self.id = id
        self.photo = photo
    }
}
