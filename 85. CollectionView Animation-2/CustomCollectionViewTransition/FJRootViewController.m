//
//  FJRootViewController.m
//  CustomCollectionViewTransition
//
//  Created by Engin Kurutepe on 01/05/14.
//  Copyright (c) 2014 Fifteen Jugglers Software. All rights reserved.
//

#import "FJRootViewController.h"
#import "FJCollectionDataSource.h"
#import "FJLineToGridAnimator.h"
#import "FJContainerCell.h"
#import "FJDetailViewController.h"

@interface FJRootViewController ()

@property (nonatomic, strong) NSArray *dataSources;
@property (nonatomic, weak) UICollectionView *sourceCollectionView;
@end

@implementation FJRootViewController

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
    self.navigationController.delegate = self;
    self.dataSources = @[
                         [[FJCollectionDataSource alloc]initWithColor:[UIColor redColor] numberOfItems:10],
                         [[FJCollectionDataSource alloc]initWithColor:[UIColor greenColor] numberOfItems:10],
                         [[FJCollectionDataSource alloc]initWithColor:[UIColor blueColor] numberOfItems:10],
                         [[FJCollectionDataSource alloc]initWithColor:[UIColor orangeColor] numberOfItems:10],
                         [[FJCollectionDataSource alloc]initWithColor:[UIColor yellowColor] numberOfItems:10],
                         [[FJCollectionDataSource alloc]initWithColor:[UIColor magentaColor] numberOfItems:10],
                         [[FJCollectionDataSource alloc]initWithColor:[UIColor cyanColor] numberOfItems:10],
                         [[FJCollectionDataSource alloc]initWithColor:[UIColor purpleColor] numberOfItems:10]
                         ];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation




- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [_dataSources count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FJContainerCell *containerCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ContainerCell" forIndexPath:indexPath];
    
    UICollectionView *childCollectionView = containerCell.collectionView;
    
    childCollectionView.dataSource = _dataSources[indexPath.section];
    
    return containerCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    FJDetailViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"FJDetailViewController"];
        
    dvc.dataSource = collectionView.dataSource;
    
    self.sourceCollectionView = collectionView;
    
    [self.navigationController pushViewController:dvc animated:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    if (fromVC == self && operation == UINavigationControllerOperationPush) {
        FJLineToGridAnimator *animator = [[FJLineToGridAnimator alloc] init];
        animator.fromCollectionView = self.sourceCollectionView;
        return animator;
    }
    else {
        return nil;
    }
}

@end
