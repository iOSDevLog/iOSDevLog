//
//  Tweet.h
//  TwitterInstant
//
//  Created by JiaXianhua on 15/10/19.
//  Copyright © 2015年 iOSDevLog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject

@property (strong, nonatomic) NSString *status;

@property (strong, nonatomic) NSString *profileImageUrl;

@property (strong, nonatomic) NSString *username;

+ (instancetype)tweetWithStatus:(NSDictionary *)status;

@end
