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
    var id: Double
    var user: User
    var text: String
    var entities: Entity
    var time: NSDate
    
    static func parseJSONArray(jsonArray: [JSONValue]) -> [Tweet] {
        return jsonArray.map({ e in return Tweet.parseJSON(e) })
    }
    
    static func parseJSON(json: JSONValue) -> Tweet {
        return Tweet(id: json["id"].double!,
                     user: User.parseJSON(json["user"]),
                     text: json["text"].string!,
                     entities: Entity.parseJSON(json["entities"]),
                     time: Tweet.parseDate(json["created_at"].string!))
    }
    
    private static func parseDate(date: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "eee MMM dd HH:mm:ss ZZZZ yyyy"
        return dateFormatter.dateFromString(date)!
    }
}
