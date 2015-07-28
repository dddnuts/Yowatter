//
//  Tweet.swift
//  Yowatter
//
//  Created by t-matsumura on 7/26/15.
//  Copyright (c) 2015 dddnuts. All rights reserved.
//

import UIKit
import SwifteriOS

struct Tweet {
    var identifier: NSNumber
    var user: User
    var text: String
    
    static func parseJSONArray(jsonArray: [JSONValue]) -> [Tweet] {
        return jsonArray.map({
            m in
            
            return Tweet.parseJSON(m)
        })
    }
    
    static func parseJSON(json: JSONValue) -> Tweet {
        return Tweet(identifier: 1, user: User.parseJSON(json["user"]), text: json["text"].string!)
    }
}
