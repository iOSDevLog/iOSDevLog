//
//  Tweet.swift
//  Twitter
//
//  Created by CS193p Instructor.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import Foundation

// a simple container class which just holds the data in a Tweet
// IndexedKeywords are substrings of the Tweet's text
// for example, a hashtag or other user or url that is mentioned in the Tweet
// note carefully the comments on the two range properties in an IndexedKeyword
// Tweet instances re created by fetching from Twitter using a TwitterRequest

public class Tweet : CustomStringConvertible
{
    public let text: String!
    public let user: User!
    public let created: NSDate!
    public let id: String?
    public let media: [MediaItem]
    public let hashtags: [IndexedKeyword]
    public let urls: [IndexedKeyword]
    public let userMentions: [IndexedKeyword]

    public struct IndexedKeyword: CustomStringConvertible
    {
        public let keyword: String              // will include # or @ or http:// prefix
        public let range: Range<String.Index>   // index into the Tweet's text property only
        public let nsrange: NSRange             // index into an NS[Attributed]String made from the Tweet's text

        public init?(data: NSDictionary?, inText: String, prefix: String?) {
            let indices = data?.valueForKeyPath(TwitterKey.Entities.Indices) as? NSArray
            if let startIndex = (indices?.firstObject as? NSNumber)?.integerValue {
                if let endIndex = (indices?.lastObject as? NSNumber)?.integerValue {
                    let length = inText.characters.count
                    if length > 0 {
                        let start = max(min(startIndex, length-1), 0)
                        let end = max(min(endIndex, length), 0)
                        if end > start {
                            var adjustedRange = inText.startIndex.advancedBy(start)...inText.startIndex.advancedBy(end-1)
                            var keywordInText = inText.substringWithRange(adjustedRange)
                            if prefix != nil && !keywordInText.hasPrefix(prefix!) && start > 0 {
                                adjustedRange = inText.startIndex.advancedBy(start-1)...inText.startIndex.advancedBy(end-2)
                                keywordInText = inText.substringWithRange(adjustedRange)
                            }
                            range = adjustedRange
                            keyword = keywordInText
                            if prefix == nil || keywordInText.hasPrefix(prefix!) {
                                nsrange = inText.rangeOfString(keyword, nearRange: NSMakeRange(startIndex, endIndex-startIndex))
                                if nsrange.location != NSNotFound {
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
                    }
                }
            }
            // it is possible we will get here without all properties being initialized
            // hopefully that won't cause a problem even though the compiler does not complain? :)
            return nil
        }

        public var description: String { get { return "\(keyword) (\(nsrange.location), \(nsrange.location+nsrange.length-1))" } }
    }
    
    public var description: String { return "\(user) - \(created)\n\(text)\nhashtags: \(hashtags)\nurls: \(urls)\nuser_mentions: \(userMentions)" + (id == nil ? "" : "\nid: \(id!)") }

    // MARK: - Private Implementation

    init?(data: NSDictionary?) {
        user = User(data: data?.valueForKeyPath(TwitterKey.User) as? NSDictionary)
        text = data?.valueForKeyPath(TwitterKey.Text) as? String
        created = (data?.valueForKeyPath(TwitterKey.Created) as? String)?.asTwitterDate
        id = data?.valueForKeyPath(TwitterKey.ID) as? String
        var accumulatedMedia = [MediaItem]()
        if let mediaEntities = data?.valueForKeyPath(TwitterKey.Media) as? NSArray {
            for mediaData in mediaEntities {
                if let mediaItem = MediaItem(data: mediaData as? NSDictionary) {
                    accumulatedMedia.append(mediaItem)
                }
            }
        }
        media = accumulatedMedia
        let hashtagMentionsArray = data?.valueForKeyPath(TwitterKey.Entities.Hashtags) as? NSArray
        hashtags = Tweet.getIndexedKeywords(hashtagMentionsArray, inText: text, prefix: "#")
        let urlMentionsArray = data?.valueForKeyPath(TwitterKey.Entities.URLs) as? NSArray
        urls = Tweet.getIndexedKeywords(urlMentionsArray, inText: text, prefix: "h")
        let userMentionsArray = data?.valueForKeyPath(TwitterKey.Entities.UserMentions) as? NSArray
        userMentions = Tweet.getIndexedKeywords(userMentionsArray, inText: text, prefix: "@")
        
        if user == nil || text == nil || created == nil {
            return nil
        }
    }

    private class func getIndexedKeywords(dictionary: NSArray?, inText: String, prefix: String? = nil) -> [IndexedKeyword] {
        var results = [IndexedKeyword]()
        if let indexedKeywords = dictionary {
            for indexedKeywordData in indexedKeywords {
                if let indexedKeyword = IndexedKeyword(data: indexedKeywordData as? NSDictionary, inText: inText, prefix: prefix) {
                    results.append(indexedKeyword)
                }
            }
        }
        return results
    }
    
    struct TwitterKey {
        static let User = "user"
        static let Text = "text"
        static let Created = "created_at"
        static let ID = "id_str"
        static let Media = "entities.media"
        struct Entities {
            static let Hashtags = "entities.hashtags"
            static let URLs = "entities.urls"
            static let UserMentions = "entities.user_mentions"
            static let Indices = "indices"
        }
    }
}

private extension NSString {
    func rangeOfString(substring: NSString, nearRange: NSRange) -> NSRange {
        var start = max(min(nearRange.location, length-1), 0)
        var end = max(min(nearRange.location + nearRange.length, length), 0)
        var done = false
        while !done {
            let range = self.rangeOfString(substring as String, options: NSStringCompareOptions(), range: NSMakeRange(start, end-start))
            if range.location != NSNotFound {
                return range
            }
            done = true
            if start > 0 { start-- ; done = false }
            if end < length { end++ ; done = false }
        }
        return NSMakeRange(NSNotFound, 0)
    }
}

private extension String {
    var asTwitterDate: NSDate? {
        get {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
            return dateFormatter.dateFromString(self)
        }
    }
}
