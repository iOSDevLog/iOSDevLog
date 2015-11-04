//
//  StaticVideoViewController.swift
//  CoreImageVideo
//
//  Created by Chris Eidhof on 03/04/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import UIKit
import AVFoundation

class StaticVideoViewController: UIViewController {
    var coreImageView: CoreImageView?
    var videoSource: VideoSampleBufferSource?
    
    var angleForCurrentTime: Float {
        return Float(NSDate.timeIntervalSinceReferenceDate() % M_PI*2)
    }
    
    override func loadView() {
        coreImageView = CoreImageView(frame: CGRect())
        self.view = coreImageView
    }
    
    override func viewDidAppear(animated: Bool) {
        let url = NSBundle.mainBundle().URLForResource("Cat", withExtension: "mp4")!
        videoSource = VideoSampleBufferSource(url: url) { [unowned self] buffer in
            let image = CIImage(CVPixelBuffer: buffer)
            let background = kaleidoscope()(image)
            let mask = radialGradient(image.extent.center, radius: CGFloat(self.angleForCurrentTime) * 100)
            let output = blendWithMask(image, mask: mask)(background)
            self.coreImageView?.image = output
        }
    }    
}