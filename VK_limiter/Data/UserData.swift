//
//  UserData.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 10/07/2019.
//  Copyright © 2019 Aleksei Kanatev. All rights reserved.
//

import Foundation
import UIKit

let diCaprioPhotoSet:  [UIImage] = [UIImage (named: "DiCaprio1")!,
                                    UIImage (named: "DiCaprio2")!,
                                    UIImage (named: "DiCaprio3")!,
                                    UIImage (named: "DiCaprio4")!,
                                    UIImage (named: "DiCaprio5")!,
                                    UIImage (named: "DiCaprio6")!,
                                    UIImage (named: "DiCaprio7")!,
                                    UIImage (named: "DiCaprio8")!,
                                    UIImage (named: "DiCaprio9")!,
                                    UIImage (named: "DiCaprio10")!]

let joliePhotoSet:  [UIImage] = [UIImage (named: "racoon1")!,
                                 UIImage (named: "racoon2")!]



let lawrencePhotoSet: [UIImage] = [UIImage (named: "dog1")!,
                             UIImage (named: "dog2")!,
                             UIImage (named: "dog3")!,
                             UIImage (named: "dog4")!,
                             UIImage (named: "dog5")!,
                             UIImage (named: "dog6")!,
                             UIImage (named: "dog7")!]

let photoSet2: [UIImage] = [UIImage (named: "racoon1")!,
                            UIImage (named: "racoon2")!,
                            UIImage (named: "racoon3")!,
                            UIImage (named: "racoon4")!,
                            UIImage (named: "racoon5")!,
                            UIImage (named: "racoon6")!,
                            UIImage (named: "racoon7")!,
                            UIImage (named: "racoon8")!]

let photoSet3: [UIImage] = [UIImage (named: "cat1")!,
                            UIImage (named: "cat2")!,
                            UIImage (named: "cat3")!,
                            UIImage (named: "cat4")!,
                            UIImage (named: "cat5")!]

let photoSet4: [UIImage] = [UIImage (named: "fish1")!,
                            UIImage (named: "fish2")!,
                            UIImage (named: "fish3")!,
                            UIImage (named: "fish4")!,
                            UIImage (named: "fish5")!,
                            UIImage (named: "fish6")!]

let photoSet5: [UIImage] = [UIImage (named: "hamster1")!,
                            UIImage (named: "hamster2")!,
                            UIImage (named: "hamster3")!,
                            UIImage (named: "hamster4")!,
                            UIImage (named: "hamster5")!]

let photoSet6: [UIImage] = [UIImage (named: "parrot1")!,
                            UIImage (named: "parrot2")!,
                            UIImage (named: "parrot3")!,
                            UIImage (named: "parrot4")!,
                            UIImage (named: "parrot5")!,
                            UIImage (named: "parrot6")!]

let photoSet7: [UIImage] = [UIImage (named: "chinchilla1")!,
                            UIImage (named: "chinchilla2")!,
                            UIImage (named: "chinchilla3")!,
                            UIImage (named: "chinchilla4")!,
                            UIImage (named: "chinchilla5")!,
                            UIImage (named: "chinchilla6")!,
                            UIImage (named: "chinchilla7")!]

let photoSet8: [UIImage] = [UIImage (named: "rabbit1")!,
                            UIImage (named: "rabbit2")!,
                            UIImage (named: "rabbit3")!,
                            UIImage (named: "rabbit4")!,
                            UIImage (named: "rabbit5")!,
                            UIImage (named: "rabbit6")!]

let photoSet9: [UIImage] = [UIImage (named: "turtle1")!,
                            UIImage (named: "turtle2")!,
                            UIImage (named: "turtle3")!,
                            UIImage (named: "turtle4")!,
                            UIImage (named: "turtle5")!,
                            UIImage (named: "turtle6")!,
                            UIImage (named: "turtle7")!,
                            UIImage (named: "turtle8")!]

let photoSet1: [UIImage] = [UIImage (named: "seahorse1")!,
                            UIImage (named: "seahorse2")!,
                            UIImage (named: "seahorse3")!,
                            UIImage (named: "seahorse4")!,
                            UIImage (named: "seahorse5")!,
                            UIImage (named: "seahorse6")!]

let photoSet11: [UIImage] = [UIImage (named: "dolphin1")!,
                             UIImage (named: "dolphin2")!,
                             UIImage (named: "dolphin3")!,
                             UIImage (named: "dolphin4")!,
                             UIImage (named: "dolphin5")!,
                             UIImage (named: "dolphin6")!,
                             UIImage (named: "dolphin7")!,
                             UIImage (named: "dolphin8")!]


var friendsArray: [UserStruct] = [
    UserStruct(name: "Jolie", avatar: UIImage(named: "Jolie"), photoArray: joliePhotoSet),
    UserStruct(name: "DiCaprio", avatar: UIImage(named: "DiCaprio"), photoArray: diCaprioPhotoSet),
    UserStruct(name: "Lawrence", avatar: UIImage(named: "Lawrence"), photoArray: lawrencePhotoSet),
    UserStruct(name: "Pitt", avatar: UIImage(named: "Pitt"), photoArray: photoSet4),
    UserStruct(name: "Portman", avatar: UIImage(named: "Portman"), photoArray: photoSet5)
]


var groupsArray: [GroupStruct] = [
    GroupStruct(groupName: "Arduino", groupAvatar: UIImage (named: "Arduino")),
    GroupStruct(groupName: "GeekBrains", groupAvatar: UIImage (named: "GeekBrains")),
    GroupStruct(groupName: "Apple", groupAvatar: UIImage (named: "Apple")),
    GroupStruct(groupName: "Goose", groupAvatar: UIImage (named: "Goose"))
]


let allGroupsArray: [GroupStruct] = [
    GroupStruct(groupName: "Science", groupAvatar: UIImage (named: "Science")),
    GroupStruct(groupName: "Steampunk", groupAvatar: UIImage (named: "Steampunk")),
    GroupStruct(groupName: "Travel", groupAvatar: UIImage (named: "Travel"))
]
