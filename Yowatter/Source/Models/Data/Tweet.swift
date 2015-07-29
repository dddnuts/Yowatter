//
//  Tweet.swift
//  Yowatter
//
//  Created by dddnuts on 7/26/15.
//  Copyright (c) 2015 dddnuts. All rights reserved.
//

import UIKit
import SwifteriOS

struct Tweet {
    var id: Int
    var user: User
    var text: String
    var entities: Entity
    
    static func parseJSONArray(jsonArray: [JSONValue]) -> [Tweet] {
        return jsonArray.map({ e in return Tweet.parseJSON(e) })
    }
    
    static func parseJSON(json: JSONValue) -> Tweet {
        return Tweet(id: json["id"].integer!,
                     user: User.parseJSON(json["user"]),
                     text: json["text"].string!,
                     entities: Entity.parseJSON(json["entities"]))
    }
}
