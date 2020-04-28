//
//  Constants.swift
//  denemeCanim
//
//  Created by Umut Geyik on 14/03/2020.
//  Copyright © 2020 ProMac. All rights reserved.


struct Constants {
    
    static let registerSegue = "RegisterToSocial"
    static let loginSegue = "LoginToSocial"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let mainTabBar = "MainTabController"
    static let cellReusable = "SocialReusable"
    static let cellName = "SocialCell"
    static let searchCellName = "SearchCell"
    static let searchCellReusable = "SearchReusable"
    
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }

    
}

