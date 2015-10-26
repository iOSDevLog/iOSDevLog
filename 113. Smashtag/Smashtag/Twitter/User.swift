//
//  User.swift
//  Twitter
//
//  Created by CS193p Instructor.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import Foundation

// container to hold data about a Twitter user

public struct User: CustomStringConvertible
{
    public let screenName: String
    public let name: String
    public let profileImageURL: NSURL?
    public let verified: Bool
    public let id: String?
    
    public var description: String { let v = verified ? " ✅" : ""; return "@\(screenName) (\(name))\(v)" }

    // MARK: - Private Implementation

    init?(data: NSDictionary?) {
        if let nameFromData = data?.valueForKeyPath(TwitterKey.Name) as? String {
            if let screenNameFromData = data?.valueForKeyPath(TwitterKey.ScreenName) as? String {
                name = nameFromData
                screenName = screenNameFromData
                id = data?.valueForKeyPath(TwitterKey.ID) as? String
                verified = data?.valueForKeyPath(TwitterKey.Verified)?.boolValue ?? false
                if let urlString = data?.valueForKeyPath(TwitterKey.ProfileImageURL) as? String {
                    profileImageURL = NSURL(string: urlString)
                } else {
                    profileImageURL = nil
                }
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
        // it is possible we will get here without all properties being initialized
        // hopefully that won't cause a problem even though the compiler does not complain? :)
        return nil
    }

    var asPropertyList: AnyObject {
        var dictionary = Dictionary<String,String>()
        dictionary[TwitterKey.Name] = self.name
        dictionary[TwitterKey.ScreenName] = self.screenName
        dictionary[TwitterKey.ID] = self.id
        dictionary[TwitterKey.Verified] = verified ? "YES" : "NO"
        dictionary[TwitterKey.ProfileImageURL] = profileImageURL?.absoluteString
        return dictionary
    }

    struct TwitterKey {
        static let Name = "name"
        static let ScreenName = "screen_name"
        static let ID = "id_str"
        static let Verified = "verified"
        static let ProfileImageURL = "profile_image_url"
    }
}
