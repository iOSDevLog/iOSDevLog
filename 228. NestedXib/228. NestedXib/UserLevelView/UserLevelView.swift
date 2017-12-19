//
//  UserLevelView.swift
//  228. NestedXib
//
//  Created by iOS Dev Log on 2017/12/19.
//  Copyright © 2017年 iOSDevLog. All rights reserved.
//

import UIKit

class UserLevelView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let containerView = UINib(nibName: "UserLevelView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as? UIView
        containerView?.frame = bounds
        addSubview(containerView!)
    }
}
