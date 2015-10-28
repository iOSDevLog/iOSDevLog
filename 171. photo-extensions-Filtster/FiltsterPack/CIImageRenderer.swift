/*
*   Copyright 2015 Sam Davies
*
*   Licensed under the Apache License, Version 2.0 (the "License");
*   you may not use this file except in compliance with the License.
*   You may obtain a copy of the License at
*
*   http://www.apache.org/licenses/LICENSE-2.0
*
*   Unless required by applicable law or agreed to in writing, software
*   distributed under the License is distributed on an "AS IS" BASIS,
*   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*   See the License for the specific language governing permissions and
*   limitations under the License.
*/


import CoreImage
import GLKit

public class CIImageRendererView: GLKView {
  var renderContext: CIContext
  public var image: CIImage! {
    didSet {
      setNeedsDisplay()
    }
  }
  
  override public init(frame: CGRect, context: EAGLContext) {
    renderContext = CIContext(EAGLContext: context)
    super.init(frame: frame, context: context)
    enableSetNeedsDisplay = true
  }
  
  public required init?(coder aDecoder: NSCoder) {
    let eaglContext = EAGLContext(API: .OpenGLES2)
    renderContext = CIContext(EAGLContext: eaglContext)
    super.init(coder: aDecoder)
    context = eaglContext
    enableSetNeedsDisplay = true
  }
  
  override public func drawRect(rect: CGRect) {
    if let image = image {
      let imageSize = image.extent.size
      var drawFrame = CGRectMake(0, 0, CGFloat(drawableWidth), CGFloat(drawableHeight))
      let imageAR = imageSize.width / imageSize.height
      let viewAR = drawFrame.width / drawFrame.height
      if imageAR > viewAR {
        drawFrame.origin.y += (drawFrame.height - drawFrame.width / imageAR) / 2.0
        drawFrame.size.height = drawFrame.width / imageAR
      } else {
        drawFrame.origin.x += (drawFrame.width - drawFrame.height * imageAR) / 2.0
        drawFrame.size.width = drawFrame.height * imageAR
      }
      
      // clear eagl view to black
      glClearColor(0.0, 0.0, 0.0, 1.0);
      glClear(0x00004000)
      
      // set the blend mode to "source over" so that CI will use that
      glEnable(0x0BE2);
      glBlendFunc(1, 0x0303);
      
      renderContext.drawImage(image, inRect: drawFrame, fromRect: image.extent)
    }
  }
}
