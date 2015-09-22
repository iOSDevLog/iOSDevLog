//
//  HappinessViewController.swift
//  Happiness
//
//  Created by jiaxianhua on 15/9/21.
//  Copyright © 2015年 com.jiaxh. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {
    
    @IBOutlet weak var faceView: FaceView! {
        // the property observer didSet gets called when this outlet gets set
        // (i.e. when iOS makes the connection to the FaceView in the storyboard)
        // this is a perfect time to configure the FaceView with its delegate and recognizers
        didSet {
            faceView.dataSource = self
            // this pinch gesture can be handled by the View, so just "turn it on" here in the Controller
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
            // this pan gesture recognizer modifies the Model so it must be handled by the Controller
            // we could add it in code like below, but instead, we added it directly in the storyboard
            // and wired it up with ctrl-drag
            // faceView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "changeHappiness:"))
        }
    }
    
    // a property to access our Model
    // incredibly simplistic Model
    // most MVCs would have more complicated Models (e.g. CalculatorBrain)
    var happiness: Int = 25 { // 0 = very sad, 100 = ecstatic
        didSet {
            // validate (actually, enforce validity of) modifications to the Model
            happiness = min(max(happiness, 0), 100)
            print("happiness = \(happiness)")
            // any time the Model changes, we need to update our View
            updateUI()
        }
    }
    
    func updateUI() {
        // to update our UI, we just need to ask the FaceView to redraw
        faceView.setNeedsDisplay()
    }
    
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
    }
    
    
    // FaceViewDataSource
    func smilinessForFaceView(sender: FaceView) -> Double? {
        // interpret the Model for the View
        return Double(happiness-50)/50
    }
}
