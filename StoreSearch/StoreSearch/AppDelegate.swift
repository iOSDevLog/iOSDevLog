//
//  AppDelegate.swift
//  StoreSearch
//
//  Created by iosdevlog on 16/2/22.
//  Copyright © 2016年 iosdevlog. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - property
    var window: UIWindow?

    // MARK: - delegate
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        customizeAppearance()
        
        return true
    }
    
    // MARK: - helper
    func customizeAppearance() {
        let barTintColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 1)
        UISearchBar.appearance().barTintColor = barTintColor
        
        window!.tintColor = UIColor(red: 10/255, green: 80/255, blue: 80/255, alpha: 1)
    }
}
