//
//  ItemDetailViewController.swift
//  Checklists
//
//  Created by iosdevlog on 15/12/31.
//  Copyright © 2015年 iosdevlog. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func addItemViewControllerDidCancel(controller: ItemDetailViewController)
    func addItemViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
    func addItemViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!

    // MARK: - outlet
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var shouldRemindSwitch: UISwitch!
    
    @IBOutlet weak var dueDateLabel: UILabel!
    
    @IBOutlet var datePickerCell: UITableViewCell!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: ItemDetailViewControllerDelegate?
    
    var itemToEdit: ChecklistItem?
    
    var dueDate = NSDate()
    
    var datePickerVisible = false
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.enabled = true
            
            shouldRemindSwitch.on = item.shouldRemind
            dueDate = item.dueDate
        }
        
        updateDueDateLabel()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        textField.becomeFirstResponder()
    }
    
    // MARK: - Action
    @IBAction func cancel() {
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let item = itemToEdit {
            item.text = textField.text!
            item.shouldRemind = shouldRemindSwitch.on
            item.dueDate = dueDate
            item.scheduleNotification()
            delegate?.addItemViewController(self, didFinishEditingItem: item)
        } else {
            let item = ChecklistItem()
            item.text = textField.text!
            item.checked = false
            item.shouldRemind = shouldRemindSwitch.on
            item.dueDate = dueDate
            item.scheduleNotification()
            
            delegate?.addItemViewController(self, didFinishAddingItem: item)
        }
    }
    
    @IBAction func dateChanged(sender: UIDatePicker) {
        dueDate = sender.date
        updateDueDateLabel()
    }
    
    @IBAction func shouldRemindToggled(sender: UISwitch) {
        textField.resignFirstResponder()
        if sender.on {
            let notifacationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Sound, .Badge], categories: nil)
            UIApplication.sharedApplication().registerUserNotificationSettings(notifacationSettings)
        }
    }
    
    // MARK: - tableview data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 && datePickerVisible {
            return 3
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 1 && indexPath.row == 2 {
            return datePickerCell
        } else {
            return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        }
    }
    
    // MARK: - tableview delegate
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if indexPath.section == 1 && indexPath.row == 1 {
            return indexPath
        } else {
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        textField.resignFirstResponder()
        
        if indexPath.section == 1 && indexPath.row == 1 {
            if !datePickerVisible {
                showDatePicker()
            } else {
                hideDatePicker()
            }
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 2 {
            return 217
        } else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, var indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        if indexPath.section == 1 && indexPath.row == 2 {
            indexPath = NSIndexPath(forRow: 0, inSection: indexPath.section)
        }
        
        return super.tableView(tableView, indentationLevelForRowAtIndexPath: indexPath)
    }
    
    // MARK: - textfield delegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
        doneBarButton.enabled = (newText.length > 0)
        
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        hideDatePicker()
    }
    
    // MARK: - update UI
    func updateDueDateLabel() {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .ShortStyle
        dueDateLabel.text = formatter.stringFromDate(dueDate)
    }
    
    // MARK: show / hide datePicker
    func showDatePicker() {
        datePickerVisible = true
        
        let dateRowIndexPath = NSIndexPath(forRow: 1, inSection: 1)
        let datePickerIndexPath = NSIndexPath(forRow: 2, inSection: 1)
        
        if let dateCell = tableView.cellForRowAtIndexPath(dateRowIndexPath) {
            dateCell.detailTextLabel?.textColor = dateCell.detailTextLabel?.tintColor
        }
        
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([datePickerIndexPath], withRowAnimation: .Fade)
        tableView.reloadRowsAtIndexPaths([dateRowIndexPath], withRowAnimation: .None)
        tableView.endUpdates()
        
        datePicker.setDate(dueDate, animated: false)
    }
    
    func hideDatePicker() {
        if datePickerVisible {
            datePickerVisible = false
            
            let dateRowIndexPath = NSIndexPath(forRow: 1, inSection: 1)
            let datePickerIndexPath = NSIndexPath(forRow: 2, inSection: 1)
            
            if let dateCell = tableView.cellForRowAtIndexPath(dateRowIndexPath) {
                dateCell.detailTextLabel?.textColor = UIColor(white: 0, alpha: 0.5)
            }
            
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths([datePickerIndexPath], withRowAnimation: .Fade)
            tableView.reloadRowsAtIndexPaths([dateRowIndexPath], withRowAnimation: .None)
            tableView.endUpdates()
            
            datePicker.setDate(dueDate, animated: false)
        }
    }
}
