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

public protocol FiltsterFilterDelegate {
  func outputImageDidUpdate(outputImage: CIImage)
}

public class FiltsterFilter {
  // MARK:- Filter info
  public let filterIdentifier: String = "com.shinobicontrols.filster"
  public let filterVersion: String    = "1.0"
  
  // MARK:- Public properties
  public var delegate: FiltsterFilterDelegate?
  
  public init() {
  }
  
  public var inputImage: CIImage! {
    didSet {
      performFilter()
    }
  }
  
  // MARK:- Filter Parameters
  public var vignetteIntensity: Double = 1.0 {
    didSet {
      performFilter()
    }
  }
  
  public var vignetteRadius: Double = 0.5 {
    didSet {
      performFilter()
    }
  }
  
  public var sepiaIntensity: Double = 1.0 {
    didSet {
      performFilter()
    }
  }
  
  // MARK:- Output images
  public var outputImage: CIImage {
    let filter = vignette(vignetteRadius, intensity: vignetteIntensity)
             >>> sepia(sepiaIntensity)
    return filter(inputImage)
  }
  
  // MARK:- Private methods
  private func performFilter() {
    delegate?.outputImageDidUpdate(outputImage)
  }
}

// MARK:- Filter Serialization
extension FiltsterFilter {
  public func supportsFilterIdentifier(identifier: String, version: String) -> Bool {
    return identifier == filterIdentifier && version == filterVersion
  }
  
  public func importFilterParameters(data: NSData?) {
    if let data = data {
      if let dataDict = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [String : AnyObject] {
        vignetteIntensity = dataDict["vignetteIntensity"] as? Double ?? vignetteIntensity
        vignetteRadius    = dataDict["vignetteRadius"]    as? Double ?? vignetteRadius
        sepiaIntensity    = dataDict["sepiaIntensity"]    as? Double ?? sepiaIntensity
      }
    }
  }
  
  public func encodeFilterParameters() -> NSData {
    var dataDict = [String : AnyObject]()
    dataDict["vignetteIntensity"] = vignetteIntensity
    dataDict["vignetteRadius"]    = vignetteRadius
    dataDict["sepiaIntensity"]    = sepiaIntensity
    return NSKeyedArchiver.archivedDataWithRootObject(dataDict)
  }
}