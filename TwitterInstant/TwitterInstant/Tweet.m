//
//  Tweet.m
//  TwitterInstant
//
//  Created by JiaXianhua on 15/10/19.
//  Copyright © 2015年 iOSDevLog. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

+ (instancetype)tweetWithStatus:(NSDictionary *)status {
    Tweet *tweet = [Tweet new];
    tweet.status = status[@"text"];
    
    NSDictionary *user = status[@"user"];
    tweet.profileImageUrl = user[@"profile_image_url"];
    tweet.username = user[@"screen_name"];
    return tweet;
}

@end
