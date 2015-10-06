//
//  EditWaypointViewController.swift
//  Trax
//
//  Created by jiaxianhua on 15/10/6.
//  Copyright © 2015年 com.jiaxh. All rights reserved.
//

import UIKit

class EditWaypointViewController: UIViewController {
    var waypointToEdit: EditableWaypoint?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var infoTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
