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
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var tweetImageViewAspectRatio: NSLayoutConstraint!
    
    override func awakeFromNib() {
        self.userImageView.clipsToBounds = true
        self.userImageView.layer.cornerRadius = 5
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
        
        self.tweetTextLabel.text = tweet.text
    }
    
    private func getDataFromURL(url: NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) {
            data, response, error in
            
            completion(data: data)
        }.resume()
    }
}
