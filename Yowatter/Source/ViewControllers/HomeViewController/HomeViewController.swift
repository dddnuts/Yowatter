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
    
    var twitter: Swifter?
    var tweets: [JSONValue] = []
    
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
        
        self.tweetTableView.dataSource = self
        
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
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        
        let tweet = self.tweets[indexPath.row]
        cell.textLabel?.text = tweet["text"].string
        
        return cell
    }

    // Mark: private
    
    private func showTweets(tweets: [JSONValue]?) {
        self.tweets = tweets!
        
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
