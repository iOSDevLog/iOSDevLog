//
//  AddItemViewController.swift
//  Checklists
//
//  Created by iosdevlog on 15/12/31.
//  Copyright © 2015年 iosdevlog. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBAction func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func done() {
        print("Contents of the text field: \(textField.text)")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - tableview delegate
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
}
