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

class TableViewController: UITableViewController {
    var photos = [JSON]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(.GET, "https://api.500px.com/v1/photos", parameters:["consumer_key":"uBuwcKGa9ktzoZQtGKI9otnF7yDlJBFQ9fCTHkHc"]).responseJSON() {
            jsonData in
            let data = JSON(data: jsonData.data!)
            self.photos = data["photos"].arrayValue
            
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
        
        let url = cellData["image_url"]?.stringValue
        cell.pxImageView.image = UIImage(named: url!)
        cell.pxLabel.text = cellData["description"]?.stringValue

        return cell
    }
}
