//
//  ScoreView.swift
//  28
//
//  Created by JiaXianhua on 15/9/14.
//  Copyright (c) 2015年 jiaxianhua. All rights reserved.
//

import UIKit

class ScoreView: UILabel, ScoreViewProtocol {
    var score: Int = 0 {
        didSet {
            self.text = "SCORE: \(score)"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func scoreChanged(newScore s: Int)  {
        score = s
    }
}
