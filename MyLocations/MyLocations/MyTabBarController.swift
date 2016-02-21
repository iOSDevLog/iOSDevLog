//
//  MyTabBarController.swift
//  MyLocations
//
//  Created by iosdevlog on 16/2/21.
//  Copyright © 2016年 iosdevlog. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return nil
    }
}