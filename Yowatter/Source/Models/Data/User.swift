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
        return User(name: "", screenName: "", profileImage: NSURL(string: ""))
    }
}
