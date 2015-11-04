//
//  CoreImageView.swift
//  CoreImageVideo
//
//  Created by Chris Eidhof on 03/04/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import Foundation
import GLKit

class CoreImageView: GLKView {
    var image: CIImage? {
        didSet {
            display()
        }
    }
    let coreImageContext: CIContext
    
    override convenience init(frame: CGRect) {
        let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        self.init(frame: frame, context: eaglContext)
    }
    
    override init(frame: CGRect, context eaglContext: EAGLContext) {
        coreImageContext = CIContext(EAGLContext: eaglContext)
        super.init(frame: frame, context: eaglContext)
        // We will be calling display() directly, hence this needs to be false
        enableSetNeedsDisplay = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        if let img = image {
            let scale = self.window?.screen.scale ?? 1.0
            let destRect = CGRectApplyAffineTransform(bounds, CGAffineTransformMakeScale(scale, scale))
            coreImageContext.drawImage(img, inRect: destRect, fromRect: img.extent)
        }
    }
}