//
//  HomeViewController.swift
//  Yowatter
//
//  Created by t-matsumura on 7/25/15.
//  Copyright (c) 2015 dddnuts. All rights reserved.
//

import UIKit
import SwifteriOS

class HomeViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tweetTableView: UITableView!
    
    let tweetCellId = "tweet_cell_id"
    
    var twitter: Swifter?
    var tweets: [Tweet] = []
    
    init(twitter: Swifter, nibName: String?, bundle: NSBundle?) {
        self.twitter = twitter
        super.init(nibName: nibName, bundle: bundle)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        
        self.tweetTableView.registerNib(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: tweetCellId)
        self.tweetTableView.dataSource = self
        
        self.tweetTableView.estimatedRowHeight = 120
        self.tweetTableView.rowHeight = UITableViewAutomaticDimension
        
        self.twitter?.getStatusesHomeTimelineWithCount(20, success: {
            statuses in
            
            self.showTweets(statuses)
            
        }, failure: {
            error in
            
            self.showAlert("Error", message: "Failed to receive tweets from Twitter\n\n" + error.localizedDescription)
        })
    }
    
    // Mark: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tweetCellId) as! TweetCell
        
        let tweet = self.tweets[indexPath.row]
        cell.showTweet(tweet)
        cell.layoutIfNeeded()
        
        return cell
    }

    // Mark: private
    
    private func showTweets(tweets: [JSONValue]?) {
        self.tweets = Tweet.parseJSONArray(tweets!)
        
        dispatch_async(dispatch_get_main_queue(), {
            self.tweetTableView.reloadData()
        })
    }
    
    private func showAlert(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
