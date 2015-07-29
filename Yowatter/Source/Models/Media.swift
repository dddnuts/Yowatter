//
//  Media.swift
//  Yowatter
//
//  Created by dddnuts on 7/29/15.
//  Copyright (c) 2015 dddnuts. All rights reserved.
//

import UIKit
import SwifteriOS

struct Media {
    var id: Int
    var url: NSURL?
    
    static func parseJSONArray(jsonArray: [JSONValue]) -> [Media] {
        return jsonArray.map({ e in return Media.parseJSON(e) })
    }
    
    static func parseJSON(json: JSONValue) -> Media {
        return Media(id: json["id"].integer!, url: NSURL(string: json["url"].string!))
    }
}
