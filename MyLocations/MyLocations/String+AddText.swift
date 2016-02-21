//
//  String+AddText.swift
//  MyLocations
//
//  Created by iosdevlog on 16/2/21.
//  Copyright © 2016年 iosdevlog. All rights reserved.
//

extension String {
    mutating func addText(text: String?, withSeparator separator: String = "") {
        if let text = text {
            if !isEmpty {
                self += separator
            }
            self += text
        }
    }
}
