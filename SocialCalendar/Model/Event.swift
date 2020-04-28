//
//  Event.swift
//  denemeCanim
//
//  Created by Umut Geyik on 27/03/2020.
//  Copyright © 2020 ProMac. All rights reserved.
//

import Foundation

class Event: NSObject {
    var uid: String!
    var allDay: Bool!
    var startDate: String!
    var endDate: String!
    var eventTitle: String!
    var location: String!
    var descriptionEvent: String!
    var postID: String!
    var toShow: Int!
}
