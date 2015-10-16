//
//  TableViewCell.h
//  TwitterInstant
//
//  Created by JiaXianhua on 15/10/16.
//  Copyright © 2015年 iOSDevLog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *twitterAvatarView;
@property (weak, nonatomic) IBOutlet UILabel *twitterStatusText;
@property (weak, nonatomic) IBOutlet UILabel *twitterUsernameText;
@end
