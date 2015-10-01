//
//  TweetTableViewController.swift
//  Smashtag
//
//  Created by jiaxianhua on 15/10/1.
//  Copyright © 2015年 com.jiaxh. All rights reserved.
//

import UIKit

class TweetTableViewController: UITableViewController, UITextFieldDelegate {

    var tweets = [[Tweet]]()
    var searchText: String? = "#stanford" {
        didSet {
            searchTextField?.text = searchText
            tweets.removeAll()
            tableView.reloadData()
            refresh()
        }
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh()
    }
    
    func refresh() {
        if searchText != nil {
            let request = TwitterRequest(search: "#stanford", count: 100)
            request.fetchTweets { (newTweets) -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    if newTweets.count > 0 {
                        self.tweets.insert(newTweets, atIndex: 0)
                        self.tableView.reloadData()
                    }
                }
            }
        }

    }

    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
            searchTextField.text = searchText
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == searchTextField {
            textField.resignFirstResponder()
            searchText = textField.text
        }
        
        return true
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tweets.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets[section].count
    }

    private struct Storyboard {
        static let CellReuseIndntifier = "Tweet"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        let tweet = tweets[indexPath.section][indexPath.row]
        cell.textLabel?.text = tweet.text
        cell.detailTextLabel?.text = tweet.user.name

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
