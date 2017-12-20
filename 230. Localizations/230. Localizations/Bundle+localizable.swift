//
//  Bundle+localizable.swift
//  230. Localizations
//
//  Created by iOS Dev Log on 2017/12/20.
//  Copyright © 2017年 iOSDevLog. All rights reserved.
//

import Foundation

extension Bundle {
    class func loadLocalizableString(languageBundleName: String, key: String) -> String? {
        let languageBundlePath = Bundle.main.path(forResource: languageBundleName, ofType: "lproj")
        
        guard languageBundlePath != nil else {
            return nil
        }
        
        let languageBundle = Bundle.init(path: languageBundlePath!)
        guard languageBundle != nil else {
            return nil
        }
        
        let value = languageBundle?.localizedString(forKey: key, value: "", table: "")
        
        return value
    }
}
