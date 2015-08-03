//
//  TweetCell.swift
//  Yowatter
//
//  Created by dddnuts on 7/26/15.
//  Copyright (c) 2015 dddnuts. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var tweetImageViewHeight: NSLayoutConstraint!
    
    var tweetImageViewHeightDefault: CGFloat!;
    
    override func awakeFromNib() {
        self.userImageView.clipsToBounds = true
        self.userImageView.layer.cornerRadius = 5
        
        self.tweetImageView.clipsToBounds = true
        self.tweetImageView.layer.cornerRadius = 5
        self.tweetImageView.contentMode = .ScaleAspectFill
        self.tweetImageViewHeightDefault = self.tweetImageViewHeight.constant
    }
    
    func showTweet(tweet: Tweet) {
        var user = tweet.user
        
        // TODO: set user image
        self.getDataFromURL(user.profileImage!) { data in
            dispatch_async(dispatch_get_main_queue()) {
                self.userImageView.image = UIImage(data: data!)
            }
        }
        
        self.userNameLabel.text = user.name
        self.screenNameLabel.text = user.screenName
        self.timeLabel.text = TimeViewHelper.format(tweet.time)
        
        self.tweetTextLabel.text = tweet.text
        
        if (tweet.entities.media.count > 0) {
            var media = tweet.entities.media[0];
            self.getDataFromURL(media.url!) { data in
                dispatch_async(dispatch_get_main_queue()) {
                    self.tweetImageView.image = UIImage(data: data!)
                }
            }
            
            self.tweetImageViewHeight.constant = tweetImageViewHeightDefault
            
        } else {
            self.tweetImageView.image = nil
            self.tweetImageViewHeight.constant = 0.0
        }
    }
    
    private func getDataFromURL(url: NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) {
            data, response, error in
            
            completion(data: data)
        }.resume()
    }
}
