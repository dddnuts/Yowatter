//
//  Entity.swift
//  Yowatter
//
//  Created by dddnuts on 7/29/15.
//  Copyright (c) 2015 dddnuts. All rights reserved.
//

import UIKit
import SwifteriOS

struct Entity {
    var media: [Media]
    
    static func parseJSONArray(jsonArray: [JSONValue]) -> [Entity] {
        return jsonArray.map({ e in return Entity.parseJSON(e) })
    }
    
    static func parseJSON(json: JSON) -> Entity {        
        // What????
        switch json["media"] {
        case JSON.JSONInvalid:
            return Entity(media: [])
        default:
            return Entity(media: Media.parseJSONArray(json["media"].array!))
        }
    }
}
