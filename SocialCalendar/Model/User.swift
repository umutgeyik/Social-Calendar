//
//  User.swift
//  denemeCanim
//
//  Created by Umut Geyik on 22/03/2020.
//  Copyright © 2020 ProMac. All rights reserved.
//

import Foundation

struct User {
    let uid: String
    let name: String
    let surname: String
    let username: String
    let profile_picture: String
    
    init(uid: String, dictionar: [String: Any]){
        self.uid = uid
        self.name = dictionar["name"] as? String ?? ""
        self.surname = dictionar["surname"] as? String ?? ""
        self.username = dictionar["username"] as? String ?? ""
        self.profile_picture = dictionar["profile_picture"] as? String ?? ""
        
    }
}
