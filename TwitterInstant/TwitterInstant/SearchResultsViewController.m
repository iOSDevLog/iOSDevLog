//
//  SearchResultsViewController.m
//  TwitterInstant
//
//  Created by JiaXianhua on 15/10/16.
//  Copyright © 2015年 iOSDevLog. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "TableViewCell.h"
#import "Tweet.h"
#import "NSArray+LinqExtensions.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface SearchResultsViewController ()

@property (nonatomic, strong) NSArray *tweets;

@end

@implementation SearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tweets = [NSArray array];
}

- (void)displayTweets:(NSArray *)tweets {
    self.tweets = tweets;
    [self.tableView reloadData];
}

- (RACSignal *)signalForLoadingImage:(NSString *)imageUrl {
    RACScheduler *scheduler = [RACScheduler
                               schedulerWithPriority:RACSchedulerPriorityBackground];
    
    return [[RACSignal createSignal:^RACDisposable *(id subscriber) {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        [subscriber sendNext:image];
        [subscriber sendCompleted];
        return nil;
    }] subscribeOn:scheduler];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TableViewCell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Tweet *tweet = self.tweets[indexPath.row];
    cell.twitterStatusText.text = tweet.status;
    cell.twitterUsernameText.text = [NSString stringWithFormat:@"@%@",tweet.username];
    cell.twitterAvatarView.image = nil;
    
    [[[self signalForLoadingImage:tweet.profileImageUrl]
      deliverOn:[RACScheduler mainThreadScheduler]]
     subscribeNext:^(UIImage *image) {
         cell.twitterAvatarView.image = image;
     }];
    
    return cell;
}

@end
