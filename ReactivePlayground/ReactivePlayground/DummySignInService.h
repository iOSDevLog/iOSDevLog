//
//  DummySignInService.h
//  ReactivePlayground
//
//  Created by JiaXianhua on 15/10/16.
//  Copyright © 2015年 jiaxianhua. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RWSignInResponse)(BOOL);

@interface DummySignInService : NSObject

- (void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(RWSignInResponse)completeBlock;

@end
