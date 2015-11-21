/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    The `ListItem` class represents the text and completion state of a single item in the list.
*/

import Foundation

/**
    A `ListItem` object is composed of a text property, a completion status, and an underlying opaque identity
    that distinguishes one `ListItem` object from another. `ListItem` objects are copyable and archivable.
    To ensure that the `ListItem` class is unarchivable from an instance that was archived in the
    Objective-C version of Lister, the `ListItem` class declaration is annotated with @objc(AAPLListItem).
    This annotation ensures that the runtime name of the `ListItem` class is the same as the
    `AAPLListItem` class defined in the Objective-C version of the app. It also allows the Objective-C
    version of Lister to unarchive a `ListItem` instance that was archived in the Swift version.
*/
@objc(AAPLListItem)
final public class ListItem: NSObject, NSCoding, NSCopying, CustomDebugStringConvertible {
    // MARK: Types
    
    /**
        String constants that are used to archive the stored properties of a `ListItem`. These
        constants are used to help implement `NSCoding`.
    */
    private struct SerializationKeys {
        static let text = "text"
        static let uuid = "uuid"
        static let complete = "completed"
    }
    
    // MARK: Properties
    
    /// The text content for a `ListItem`.
    public var text: String
    
    /// Whether or not this `ListItem` is complete.
    public var isComplete: Bool
    
    /// An underlying identifier to distinguish one `ListItem` from another.
    private var UUID: NSUUID
    
    // MARK: Initializers
    
    /**
        Initializes a `ListItem` instance with the designated text, completion state, and UUID. This
        is the designated initializer for `ListItem`. All other initializers are convenience initializers.
        However, this is the only private initializer.
        
        - parameter text: The intended text content of the list item.
        - parameter complete: The item's initial completion state.
        - parameter UUID: The item's initial UUID.
    */
    private init(text: String, complete: Bool, UUID: NSUUID) {
        self.text = text
        self.isComplete = complete
        self.UUID = UUID
    }
    
    /**
        Initializes a `ListItem` instance with the designated text and completion state.
        
        - parameter text: The text content of the list item.
        - parameter complete: The item's initial completion state.
    */
    public convenience init(text: String, complete: Bool) {
        self.init(text: text, complete: complete, UUID: NSUUID())
    }
    
    /**
        Initializes a `ListItem` instance with the designated text and a default value for `isComplete`.
        The default value for `isComplete` is false.
    
        - parameter text: The intended text content of the list item.
    */
    public convenience init(text: String) {
        self.init(text: text, complete: false)
    }
    
    // MARK: NSCopying
    
    public func copyWithZone(zone: NSZone) -> AnyObject  {
        return ListItem(text: text, complete: isComplete, UUID: UUID)
    }
    
    // MARK: NSCoding
    
    public required init(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObjectForKey(SerializationKeys.text) as! String
        isComplete = aDecoder.decodeBoolForKey(SerializationKeys.complete)
        UUID = aDecoder.decodeObjectForKey(SerializationKeys.uuid) as! NSUUID
    }
    
    public func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeObject(text, forKey: SerializationKeys.text)
        encoder.encodeBool(isComplete, forKey: SerializationKeys.complete)
        encoder.encodeObject(UUID, forKey: SerializationKeys.uuid)
    }
    
    /**
        Resets the underlying identity of the `ListItem`. If a copy of this item is made, and a call
        to refreshIdentity() is made afterward, the items will no longer be equal.
    */
    public func refreshIdentity() {
        UUID = NSUUID()
    }
    
    // MARK: Overrides
    
    /**
        Overrides NSObject's isEqual(_:) instance method to return whether or not the list item is
        equal to another list item. A `ListItem` is considered to be equal to another `ListItem` if
        the underyling identities of the two list items are equal.

        - parameter object: Any object, or nil.
        
        - returns:  `true` if the object is a `ListItem` and it has the same underlying identity as the
                  receiving instance. `false` otherwise.
    */
    override public func isEqual(object: AnyObject?) -> Bool {
        if let item = object as? ListItem {
            return UUID == item.UUID
        }
        
        return false
    }
    
    // MARK: DebugPrintable
    
    public override var debugDescription: String {
        return "\"\(text)\""
    }
}
