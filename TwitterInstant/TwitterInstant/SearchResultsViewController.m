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

@interface SearchResultsViewController ()

@property (nonatomic, strong) NSArray *tweets;

@end

@implementation SearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tweets = [NSArray array];
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
    
    return cell;
}

@end
