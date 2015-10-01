//
//  MediaItem.swift
//  Twitter
//
//  Created by CS193p Instructor.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import Foundation

// holds the network url and aspectRatio of an image attached to a Tweet
// created automatically when a Tweet object is created

public struct MediaItem
{
    public let url: NSURL!
    public let aspectRatio: Double
    
    public var description: String { return (url.absoluteString ?? "no url") + " (aspect ratio = \(aspectRatio))" }
    
    // MARK: - Private Implementation

    init?(data: NSDictionary?) {
        if let urlString = data?.valueForKeyPath(TwitterKey.MediaURL) as? NSString {
            if let urlFromString = NSURL(string: urlString as String) {
                url = urlFromString
                let h = data?.valueForKeyPath(TwitterKey.Height) as? NSNumber
                let w = data?.valueForKeyPath(TwitterKey.Width) as? NSNumber
                if h != nil && w != nil && h?.doubleValue != 0 {
                    aspectRatio = w!.doubleValue / h!.doubleValue
                    // failable initializers are required to initialize all properties before returning failure
                    // (this is probably just a (temporary?) limitation of the implementation of Swift)
                    // however, it appears that (sometimes) you can "return" in the case of success like this
                    // and it avoids the warning (although "return" is sort of weird in an initializer)
                    // (this seems to work even though all the properties are NOT initialized for the "return nil" below)
                    // hopefully in future versions of Swift this will all not be an issue
                    // because you'll be allowed to fail without initializing all properties?
                    return
                }
            }
        }
        // it is possible we will get here without all properties being initialized
        // hopefully that won't cause a problem even though the compiler does not complain? :)
        return nil
    }
    
    struct TwitterKey {
        static let MediaURL = "media_url_https"
        static let Width = "sizes.small.w"
        static let Height = "sizes.small.h"
    }
}
