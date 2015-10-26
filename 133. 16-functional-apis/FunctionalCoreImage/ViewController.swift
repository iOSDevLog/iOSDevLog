//
//  ViewController.swift
//  FunctionalCoreImage
//
//  Created by Florian on 10/09/14.
//  Copyright (c) 2014 objc.io. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = CIImage(image: UIImage(named: "cover")!)
        let blurRadius = 5.0
        let overlayColor = UIColor.redColor().colorWithAlphaComponent(0.2)

        let myFilter = blur(blurRadius) >|> colorOverlay(overlayColor)
        let result = myFilter(image!)

        imageView.image = UIImage(CIImage: result)
    }

}

