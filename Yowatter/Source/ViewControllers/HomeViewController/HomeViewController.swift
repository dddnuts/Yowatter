//
//  HomeViewController.swift
//  Yowatter
//
//  Created by t-matsumura on 7/25/15.
//  Copyright (c) 2015 dddnuts. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tweetTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home";
    }
}
