//
//  ImageViewController.swift
//  Cassini
//
//  Created by jiaxianhua on 15/9/28.
//  Copyright © 2015年 com.jiaxh. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    private var imageView = UIImageView()
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
    }
}
