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

import Foundation

typealias Filter = CIImage -> CIImage
typealias Parameters = [String : AnyObject]

infix operator >>> { associativity left }
func >>> (filter1: Filter, filter2: Filter) -> Filter {
  return { img in filter2(filter1(img)) }
}


func vignette(radius: Double, intensity: Double) -> Filter {
  return { image in
    let parameters: Parameters = [
      kCIInputImageKey     : image,
      kCIInputIntensityKey : intensity,
      kCIInputRadiusKey    : radius
    ]
    
    let filter = CIFilter(name: "CIVignette", withInputParameters: parameters)
    
    return filter!.outputImage!
  }
}

func sepia(intensity: Double) -> Filter {
  return { image in
    let parameters: Parameters = [
      kCIInputImageKey     : image,
      kCIInputIntensityKey : intensity
    ]
    
    let filter = CIFilter(name: "CISepiaTone", withInputParameters: parameters)
    
    return filter!.outputImage!
  }
}
