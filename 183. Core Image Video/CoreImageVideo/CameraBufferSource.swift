//
//  CameraBufferSource.swift
//  CoreImageVideo
//
//  Created by Chris Eidhof on 03/04/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import Foundation
import AVFoundation

typealias BufferConsumer = (CMSampleBuffer, CGAffineTransform) -> ()

struct CaptureBufferSource {
    private let captureSession: AVCaptureSession
    private let captureDelegate: CaptureBufferDelegate
    var running: Bool = false {
        didSet {
            if running {
                captureSession.startRunning()
            } else {
                captureSession.stopRunning()
            }
        }
    }
    
    init?(device: AVCaptureDevice, transform: CGAffineTransform, callback: BufferConsumer) {
        captureSession = AVCaptureSession()
        if let deviceInput = try? AVCaptureDeviceInput(device: device) where captureSession.canAddInput(deviceInput) {
            captureSession.addInput(deviceInput)
            let dataOutput = AVCaptureVideoDataOutput()
            dataOutput.alwaysDiscardsLateVideoFrames = true
            dataOutput.videoSettings = pixelBufferDict
            captureDelegate = CaptureBufferDelegate { buffer in
                callback(buffer, transform)
            }
            dataOutput.setSampleBufferDelegate(captureDelegate, queue: dispatch_get_main_queue())
            captureSession.addOutput(dataOutput)
            captureSession.commitConfiguration()
            return
        }
        return nil
    }
    
    init?(position: AVCaptureDevicePosition, callback: BufferConsumer) {
        if let camera = position.device {
            self.init(device: camera, transform: position.transform, callback: callback)
            return
        }
        return nil
    }
}

private class CaptureBufferDelegate: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    let callback: CMSampleBuffer -> ()
    
    init(_ callback: CMSampleBuffer -> ()) {
        self.callback = callback
    }
    
    @objc func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        callback(sampleBuffer)
    }
}