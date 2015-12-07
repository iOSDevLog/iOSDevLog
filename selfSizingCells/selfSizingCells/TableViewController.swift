//
//  TableViewController.swift
//  selfSizingCells
//
//  Created by iosdevlog on 15/12/8.
//  Copyright © 2015年 iosdevlog. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
import DZNEmptyDataSet

class TableViewController: UITableViewController, DZNEmptyDataSetSource {
    var photos = [JSON]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.separatorStyle = .None
        
        Alamofire.request(.GET, "https://api.500px.com/v1/photos", parameters:["consumer_key":"uBuwcKGa9ktzoZQtGKI9otnF7yDlJBFQ9fCTHkHc"]).responseJSON() {
            jsonData in
            let data = JSON(data: jsonData.data!)
            self.photos = data["photos"].arrayValue
            
            self.tableView.separatorStyle = .SingleLine
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photos.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! TableViewCell

        // Configure the cell...
        let cellData = self.photos[indexPath.row].dictionaryValue
        
        let image_url = cellData["image_url"]?.stringValue
        let URL = NSURL(string:image_url!)!
        let placeholderImage = UIImage(named: "Earth")!
        
        cell.pxImageView.af_setImageWithURL(URL, placeholderImage: placeholderImage)
        
        cell.pxLabel.text = cellData["description"]?.stringValue

        return cell
    }
    
    //MARK: - DZNEmptyDataSetSource
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "Wait a minute...")
    }
    
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "Earth")
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "Do you want beautiful photos ?\nLet's Go!")
    }
}
