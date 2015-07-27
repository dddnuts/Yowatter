//
//  User.swift
//  Yowatter
//
//  Created by t-matsumura on 7/26/15.
//  Copyright (c) 2015 dddnuts. All rights reserved.
//

import UIKit
import SwifteriOS

struct User {
    var name: String
    var screenName: String
    var profileImage: NSURL?
    
    static func parseJSON(json: JSONValue) -> User {
        var name = json["name"].string!
        var screenName = "@" + json["screen_name"].string!
        var profile = NSURL(string: json["profile_image_url"].string!)
        
        return User(name: name, screenName: screenName, profileImage: profile)
    }
}
