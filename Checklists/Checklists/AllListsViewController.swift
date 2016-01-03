//
//  AllListsViewController.swift
//  Checklists
//
//  Created by iosdevlog on 16/1/3.
//  Copyright © 2016年 iosdevlog. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController {
    var lists: [Checklist]
    
    required init?(coder aDecoder: NSCoder) {
        lists = [Checklist]()
        
        super.init(coder: aDecoder)
        
        var list = Checklist(name: "Birthdays")
        lists.append(list)
        
        list = Checklist(name: "Groceries")
        lists.append(list)
        
        list = Checklist(name: "Cool Apps")
        lists.append(list)
        
        list = Checklist(name: "To Do")
        lists.append(list)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = cellForTableView(tableView)
        
        let checklist = lists[indexPath.row]
        
        cell.textLabel?.text = checklist.name
        cell.accessoryType = .DetailDisclosureButton
        
        return cell
    }

    // cellForRowAtIndexPath helper
    func cellForTableView(tableView: UITableView) -> UITableViewCell {
        let cellIedntifier = "Cell"
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellIedntifier) {
            return cell
        } else {
            return UITableViewCell(style: .Default, reuseIdentifier: cellIedntifier)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let checklist = lists[indexPath.row]
        performSegueWithIdentifier("ShowChecklist", sender: checklist)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowChecklist" {
            let controller = segue.destinationViewController as! CheckListViewController
            
            controller.checklist = sender as! Checklist
        }
    }
}
