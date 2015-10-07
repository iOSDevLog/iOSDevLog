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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    var loggedInUser: User? { didSet { updateUI() } }
    var secure: Bool = false { didSet { updateUI() } }
    
    private func updateUI() {
        passwordField.secureTextEntry = secure
        
        let password = NSLocalizedString("Password",
            comment: "Prompt for the user's password when it is not secure (i.e. plain text)")
        let securedPassword = NSLocalizedString("Secured Password",
            comment: "Prompt for an obscured (not plain text) password")
        
        passwordLabel?.text = secure ? securedPassword : password
        
        passwordLabel.text = secure ? "Secured Password" : "Password"
        nameLabel.text = loggedInUser?.name
        companyLabel.text = loggedInUser?.company
        image = loggedInUser?.image
    }
    
    @IBAction func toggleSecurity() {
        secure = !secure
    }
    
    @IBAction func login() {
        loggedInUser = User.login(loginField.text ?? "", password: passwordField.text ?? "")
    }
    
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            if let constrainedView = imageView {
                if let newImage = newValue {
                    aspectRatioConstraint = NSLayoutConstraint(item: constrainedView, attribute: .Width, relatedBy: .Equal, toItem: constrainedView, attribute: .Height, multiplier: newImage.aspectRatio, constant: 0)
                }
                else {
                    aspectRatioConstraint = nil
                }
            }
        }
    }
    
    var aspectRatioConstraint: NSLayoutConstraint? {
        willSet {
            if let existingContraint = aspectRatioConstraint {
                view.removeConstraint(existingContraint)
            }
        }
        didSet {
            if let newContraint = aspectRatioConstraint {
                view.addConstraint(newContraint)
            }
        }
    }
}

extension User {
    var image: UIImage {
        if let image = UIImage(named: login) {
            return image
        }
        else {
            return UIImage(named: "unknown_user")!
        }
    }
}

extension UIImage {
    var aspectRatio: CGFloat {
        return size.height != 0 ? size.width / size.height : 0
    }
}

