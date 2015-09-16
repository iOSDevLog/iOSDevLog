//
//  FJDetailViewController.m
//  CollectionViewAnimations
//
//  Created by Engin Kurutepe on 27/04/14.
//  Copyright (c) 2014 Fifteen Jugglers Software. All rights reserved.
//


#import "FJDetailViewController.h"
#import "FJFlowLayoutWithAnimations.h"

@interface FJDetailViewController ()

@end

@implementation FJDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _itemCount;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DetailCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    

    CGFloat colorValue = 1.0-(indexPath.item+1.0)/(2*_itemCount);
    
    cell.backgroundColor = [UIColor colorWithRed:(_color == FJSectionColorRed)?colorValue:0.0
                                           green:(_color == FJSectionColorGreen)?colorValue:0.0
                                            blue:(_color == FJSectionColorBlue)?colorValue:0.0
                                           alpha:1.0];
    
    return cell;
}

@end
