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

import UIKit
import Photos
import PhotosUI
import FiltsterPack
import CoreImage

class PhotoEditingViewController: UIViewController, PHContentEditingController,
                                  FiltsterFilterDelegate {
  
  @IBOutlet weak var filterOutputView: CIImageRendererView!
  @IBOutlet weak var vignetteRadiusSlider: UISlider!
  @IBOutlet weak var vignetteIntensitySlider: UISlider!
  @IBOutlet weak var sepiaIntensitySlider: UISlider!
  
  var input: PHContentEditingInput?
  private var dirty = false
  let filter = FiltsterFilter()
  
  let formatIdentifier = "com.shinobicontrols.filtster"
  let formatVersion    = "1.0"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    filter.delegate = self
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - PHContentEditingController
  
  func canHandleAdjustmentData(adjustmentData: PHAdjustmentData?) -> Bool {
    if let adjustmentData = adjustmentData {
      return filter.supportsFilterIdentifier(adjustmentData.formatIdentifier,
        version: adjustmentData.formatVersion)
    }
    return false
  }
  
  func startContentEditingWithInput(contentEditingInput: PHContentEditingInput?,
                                    placeholderImage: UIImage) {
    input = contentEditingInput
    filter.inputImage = CIImage(image: (input?.displaySizeImage)!)
    if let adjustmentData = contentEditingInput?.adjustmentData {
      filter.importFilterParameters(adjustmentData.data)
    }
    
    vignetteIntensitySlider.value = Float(filter.vignetteIntensity)
    vignetteRadiusSlider.value    = Float(filter.vignetteRadius)
    sepiaIntensitySlider.value    = Float(filter.sepiaIntensity)
  }
  
  func finishContentEditingWithCompletionHandler(completionHandler: ((PHContentEditingOutput!) -> Void)!) {
    // Update UI to reflect that editing has finished and output is being rendered.
    
    // Render and provide output on a background queue.
    dispatch_async(dispatch_get_global_queue(CLong(DISPATCH_QUEUE_PRIORITY_DEFAULT), 0)) {
      // Create editing output from the editing input.
      let output = PHContentEditingOutput(contentEditingInput: self.input!)
      
      // Provide new adjustments and render output to given location.
      let adjustmentData = PHAdjustmentData(formatIdentifier: self.filter.filterIdentifier,
        formatVersion: self.filter.filterVersion, data: self.filter.encodeFilterParameters())
      output.adjustmentData = adjustmentData
      
      // Write the JPEG data
      let fullSizeImage = CIImage(contentsOfURL: (self.input?.fullSizeImageURL)!)
      UIGraphicsBeginImageContext(fullSizeImage!.extent.size);
      self.filter.inputImage = fullSizeImage
      UIImage(CIImage: self.filter.outputImage).drawInRect(fullSizeImage!.extent)
      
      let outputImage = UIGraphicsGetImageFromCurrentImageContext()
      let jpegData = UIImageJPEGRepresentation(outputImage, 1.0)
      UIGraphicsEndImageContext()
      
      jpegData!.writeToURL(output.renderedContentURL, atomically: true)
      
      // Call completion handler to commit edit to Photos.
      completionHandler?(output)
    }
  }
  
  var shouldShowCancelConfirmation: Bool {
    return dirty
  }
  
  func cancelContentEditing() {
    // Clean up temporary files, etc.
    // May be called after finishContentEditingWithCompletionHandler: while you prepare output.
  }
  
  // MARK:- UI Interaction Methods
  @IBAction func handleSliderChanged(sender: UISlider) {
    switch sender {
    case vignetteRadiusSlider:
      filter.vignetteRadius = Double(sender.value)
    case vignetteIntensitySlider:
      filter.vignetteIntensity = Double(sender.value)
    case sepiaIntensitySlider:
      filter.sepiaIntensity = Double(sender.value)
    default:
        print("Shouldn't get here")
    }
    dirty = true
  }
  
  
  // MARK:- FiltsterFilterDelegate methods
  func outputImageDidUpdate(outputImage: CIImage) {
    filterOutputView.image = outputImage
  }
  
}
