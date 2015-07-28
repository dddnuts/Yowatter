//
//  Timeline.swift
//  Yowatter
//
//  Created by t-matsumura on 7/28/15.
//  Copyright (c) 2015 dddnuts. All rights reserved.
//

import UIKit

struct Timeline {
    var tweets: [Tweet]
    
    func add(tweets: [Tweet]) -> Timeline {
        return Timeline(tweets: self.tweets + tweets)
    }
    
    func sinceID() -> Int! {
        return tweets.reduce(nil, combine: {(u: Int!, tweet: Tweet) -> Int! in
            if u == nil {
                return tweet.id
            }
            return (u > tweet.id) ? u : tweet.id
        })
    }
}
