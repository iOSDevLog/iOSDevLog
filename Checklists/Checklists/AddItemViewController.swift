//
//  AddItemViewController.swift
//  Checklists
//
//  Created by iosdevlog on 15/12/31.
//  Copyright © 2015年 iosdevlog. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var doneButtonItem: UIBarButtonItem!

    // MARK: - outlet
    @IBOutlet weak var textField: UITextField!
    
    // MARK: life cycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        textField.becomeFirstResponder()
    }
    
    // MARK: - Action
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
    
    // MARK: - textfield delegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
        doneButtonItem.enabled = (newText.length > 0)
        
        return true
    }
}
