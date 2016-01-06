//
//  AppDelegate.swift
//  Checklists
//
//  Created by iosdevlog on 15/12/28.
//  Copyright © 2015年 iosdevlog. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func applicationDidEnterBackground(application: UIApplication) {
        saveData()
    }
    
    func applicationWillTerminate(application: UIApplication) {
        saveData()
    }
    
    // MARK: - helper
    func saveData() {
        let navigationController = window?.rootViewController as! UINavigationController
        let controller = navigationController.viewControllers[0] as! AllListsViewController
        
        controller.saveChecklists()
    }
}

