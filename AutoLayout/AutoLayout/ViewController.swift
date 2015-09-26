//
//  ViewController.swift
//  AutoLayout
//
//  Created by jiaxianhua on 15/9/25.
//  Copyright © 2015年 com.jiaxh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!

    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    var loggedInUser: User? { didSet { updateUI() } }
    var secure: Bool = false { didSet { updateUI() } }
    
    private func updateUI() {
        passwordField.secureTextEntry = secure
        passwordLabel.text = secure ? "Secured Password" : "Password"
    }
    
    @IBAction func toggleSecurity() {
        secure = !secure
    }
    
    @IBAction func login() {
        loggedInUser = User.login(loginField.text ?? "", password: passwordField.text ?? "")
    }
    
}

