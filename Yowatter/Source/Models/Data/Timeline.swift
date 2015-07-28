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
    
    init(tweets: [Tweet]) {
        self.tweets = tweets.sorted {
            t1, t2 in t1.id > t2.id
        }
    }
    
    func isEmpty() -> Bool {
        return self.count() == 0
    }
    
    func count() -> Int {
        return tweets.count
    }
    
    func itemAtIndex(index: Int) -> Tweet {
        return tweets[index]
    }
    
    func add(tweets: [Tweet]) -> Timeline {
        return Timeline(tweets: self.tweets + tweets)
    }
    
    func sinceID() -> Int! {
        return tweets.reduce(nil, combine: {(u: Int!, tweet: Tweet) -> Int! in
            if u == nil {
                return tweet.id
            }
            return (u > tweet.id) ? u : tweet.id
        }) + 1
    }
}
