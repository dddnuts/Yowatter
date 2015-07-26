//
//  TweetCell.swift
//  Yowatter
//
//  Created by t-matsumura on 7/26/15.
//  Copyright (c) 2015 dddnuts. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    func showTweet(tweet: Tweet) {
        var user = tweet.user
        
        // TODO: set user image
        
        self.userNameLabel.text = user.name
        self.screenNameLabel.text = user.screenName
        
        self.tweetTextLabel.text = tweet.text
    }
}
