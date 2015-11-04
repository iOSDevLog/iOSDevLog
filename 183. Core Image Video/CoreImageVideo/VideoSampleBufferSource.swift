//
//  Library.swift
//  CoreImageVideo
//
//  Created by Chris Eidhof on 03/04/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import Foundation
import AVFoundation
import GLKit

let pixelBufferDict: [String:AnyObject] =
  [kCVPixelBufferPixelFormatTypeKey as String: NSNumber(unsignedInt: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]


class VideoSampleBufferSource: NSObject {
    lazy var displayLink: CADisplayLink =
        CADisplayLink(target: self, selector: "displayLinkDidRefresh:")
    
    let videoOutput: AVPlayerItemVideoOutput
    let consumer: CVPixelBuffer -> ()
    let player: AVPlayer
    
    init?(url: NSURL, consumer callback: CVPixelBuffer -> ()) {
        player = AVPlayer(URL: url)
        consumer = callback
        videoOutput = AVPlayerItemVideoOutput(pixelBufferAttributes: pixelBufferDict)
        player.currentItem!.addOutput(videoOutput)
        
        super.init()

        start()
        player.play()
    }
    
    func start() {
        displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    func displayLinkDidRefresh(link: CADisplayLink) {
        let itemTime = videoOutput.itemTimeForHostTime(CACurrentMediaTime())
        if videoOutput.hasNewPixelBufferForItemTime(itemTime) {
            var presentationItemTime = kCMTimeZero
            let pixelBuffer = videoOutput.copyPixelBufferForItemTime(itemTime, itemTimeForDisplay: &presentationItemTime)
            consumer(pixelBuffer!)
        }

    }

}