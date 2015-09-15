//
//  ScoreView.swift
//  2048
//
//  Created by JiaXianhua on 15/9/14.
//  Copyright (c) 2015年 jiaxianhua. All rights reserved.
//

import UIKit

class ScoreView: UILabel {
    var score: Int = 0 {
        didSet {
            self.text = "Score: \(score)"
        }
    }
}
