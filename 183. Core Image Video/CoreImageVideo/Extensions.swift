//
//  Extensions.swift
//  CoreImageVideo
//
//  Created by Chris Eidhof on 03/04/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import UIKit
import AVFoundation

extension CGAffineTransform {
    
    init(rotatingWithAngle angle: CGFloat) {
        let t = CGAffineTransformMakeRotation(angle)
        self.init(a: t.a, b: t.b, c: t.c, d: t.d, tx: t.tx, ty: t.ty)
        
    }
    init(scaleX sx: CGFloat, scaleY sy: CGFloat) {
        let t = CGAffineTransformMakeScale(sx, sy)
        self.init(a: t.a, b: t.b, c: t.c, d: t.d, tx: t.tx, ty: t.ty)
        
    }
    
    func scale(sx: CGFloat, sy: CGFloat) -> CGAffineTransform {
        return CGAffineTransformScale(self, sx, sy)
    }
    func rotate(angle: CGFloat) -> CGAffineTransform {
        return CGAffineTransformRotate(self, angle)
    }
}

extension CIImage {
    convenience init(buffer: CMSampleBuffer) {
        self.init(CVPixelBuffer: CMSampleBufferGetImageBuffer(buffer)!)
    }
}

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}

extension AVCaptureDevicePosition {
    var transform: CGAffineTransform {
        switch self {
        case .Front:
            return CGAffineTransform(rotatingWithAngle: -CGFloat(M_PI_2)).scale(1, sy: -1)
        case .Back:
            return CGAffineTransform(rotatingWithAngle: -CGFloat(M_PI_2))
        default:
            return CGAffineTransformIdentity
            
        }
    }
    
    var device: AVCaptureDevice? {
        return AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo).filter {
            $0.position == self
            }.first as? AVCaptureDevice
    }
}