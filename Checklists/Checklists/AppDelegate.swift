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
    
    var dataModel = DataModel()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let navigationController = window?.rootViewController as! UINavigationController
        let controller = navigationController.viewControllers[0] as! AllListsViewController

        controller.dataModel = dataModel
        
        // local notification test
        let notifacationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Sound, .Badge], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notifacationSettings)
        
        let date = NSDate(timeIntervalSinceNow: 10)
        let localNotification = UILocalNotification()
        localNotification.fireDate = date
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.applicationIconBadgeNumber = 100
        localNotification.alertBody = "I am a local notification"
        localNotification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
        return true
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        print("didReceiveLocalNotification \(notification)")
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        saveData()
    }
    
    func applicationWillTerminate(application: UIApplication) {
        saveData()
    }
    
    // MARK: - helper
    func saveData() {
        dataModel.saveChecklists()
    }
}

