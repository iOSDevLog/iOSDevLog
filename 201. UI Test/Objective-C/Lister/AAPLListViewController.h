/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    The \c AAPLListViewController class displays the contents of a list document. It also allows the user to create, update, and delete items, change the color of the list, or delete the list.
*/

@import UIKit;
@import ListerKit;

@interface AAPLListViewController : UITableViewController <AAPLListPresenterDelegate>

@property (nonatomic, strong) AAPLListsController *listsController;
@property (nonatomic, strong) AAPLListDocument *document;
@property (nonatomic, copy) NSDictionary *textAttributes;

- (void)configureWithListInfo:(AAPLListInfo *)listInfo;

@end
