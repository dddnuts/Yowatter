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
    
    var refreshControl: UIRefreshControl!
    
    let tweetCellId = "tweet_cell_id"
    
    var twitter: Swifter?
    var timeline: Timeline = Timeline(tweets: [])
    
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
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)
        self.tweetTableView.addSubview(self.refreshControl)
        
        self.requestTweets()
    }
    
    // Mark: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.timeline.count();
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tweetCellId) as! TweetCell
        
        let tweet = self.timeline.itemAtIndex(indexPath.row)
        cell.showTweet(tweet)
        cell.layoutIfNeeded()
        
        return cell
    }
    
    // Mark: UIRefreshControl
    
    func refresh(sender: AnyObject) {
        requestTweets()
        self.refreshControl.endRefreshing()
    }
    
    // Mark: private
    
    private func requestTweets() {
        
        let sinceID: String! = self.timeline.isEmpty() ? nil : String(self.timeline.sinceID())
        
        self.twitter?.getStatusesHomeTimelineWithCount(20, sinceID: sinceID, success: {
            statuses in
            
            self.timeline = self.timeline.add(Tweet.parseJSONArray(statuses!))
            self.updateTable()
            
            }, failure: {
                error in
                
                self.showAlert("Error", message: "Failed to receive tweets from Twitter\n\n" + error.localizedDescription)
        })
    }
    
    private func updateTable() {
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
