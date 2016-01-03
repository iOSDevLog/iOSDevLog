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
        // 1
        lists = [Checklist]()
        
        // 2
        super.init(coder: aDecoder)
        
        // 3
        var list = Checklist()
        list.name = "Birthdays"
        lists.append(list)
        
        // 4
        list = Checklist()
        list.name = "Groceries"
        lists.append(list)
        
        list = Checklist()
        list.name = "Cool Apps"
        lists.append(list)
        
        list = Checklist()
        list.name = "To Do"
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
        performSegueWithIdentifier("ShowChecklist", sender: nil)
    }
}
