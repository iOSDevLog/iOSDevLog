//
//  DimmingPresentationController.swift
//  StoreSearch
//
//  Created by iosdevlog on 16/2/27.
//  Copyright © 2016年 iosdevlog. All rights reserved.
//

import UIKit

class DimmingPresentationController: UIPresentationController {
    override func shouldPresentInFullscreen() -> Bool {
        return false
    }
}
