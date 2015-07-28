//
//  AuthViewController.swift
//  Yowatter
//
//  Created by dddnuts on 7/25/15.
//  Copyright (c) 2015 dddnuts. All rights reserved.
//

import UIKit
import Accounts
import Social
import SwifteriOS

class AuthViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var accountTableView: UITableView!
    
    var swifter: Swifter?
    var accounts: [ACAccount] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Accounts"
        
        self.accountTableView.dataSource = self
        self.accountTableView.delegate = self
        
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil, completion: {
            granted, error in
            
            if !granted {
                self.showAccounts([])
                self.showAlert("Permission Denied", message: "Add permission for Twitter from Settings > Privacy > Twitter")
                return
            }
            
            let accounts = accountStore.accountsWithAccountType(accountType) as! [ACAccount];
            
            if accounts.count == 0 {
                self.showAccounts([])
                self.showAlert("No Accounts", message: "Add Twitter accounts from Settings > Twitter")
                return
            }
            
            self.showAccounts(accounts)
        })
    }
    
    // Mark: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.accounts.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        
        let account = self.accounts[indexPath.row]
        cell.textLabel?.text = "@" + account.username
        
        return cell
    }
    
    // Mark: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let account = self.accounts[indexPath.row]
        
        self.swifter = Swifter(account: account)
        
        var homeVC = HomeViewController(twitter: self.swifter!, nibName: "HomeViewController", bundle: nil)
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    // Mark: private
    
    private func showAccounts(accounts: [ACAccount]) {
        self.accounts = accounts
        
        dispatch_async(dispatch_get_main_queue(), {
            self.accountTableView.reloadData()
        })
    }
    
    private func showAlert(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
