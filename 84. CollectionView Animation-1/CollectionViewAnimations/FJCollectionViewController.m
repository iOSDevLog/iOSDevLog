//
//  FJCollectionViewController.m
//  CollectionViewAnimations
//
//  Created by Engin Kurutepe on 21/04/14.
//  Copyright (c) 2014 Fifteen Jugglers Software. All rights reserved.
//

#import "FJCollectionViewController.h"
#import "FJFlowLayoutWithAnimations.h"
#import "FJDetailViewController.h"

@interface FJCollectionViewController ()

@property (nonatomic) NSInteger sectionCount;
@property (nonatomic, strong) NSMutableArray *itemCounts;
@property (nonatomic) BOOL largeItems;
@property (nonatomic, strong) FJFlowLayoutWithAnimations *smallLayout;
@property (nonatomic, strong) FJFlowLayoutWithAnimations *largeLayout;
@property (nonatomic) NSInteger selectedItem;

@property (nonatomic, strong) UIPinchGestureRecognizer *pincher;
@end

@implementation FJCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sectionCount = 3;
    self.itemCounts = [NSMutableArray arrayWithArray:@[@(13), @(16), @(14)]];
    
    self.smallLayout = [[FJFlowLayoutWithAnimations alloc] init];
    _smallLayout.itemSize = CGSizeMake(50, 50);
    
    self.largeLayout = [[FJFlowLayoutWithAnimations alloc] init];
    _largeLayout.itemSize = CGSizeMake(200, 200);
    
    self.largeItems = NO;
    self.collectionView.collectionViewLayout = _smallLayout;
    
    UIBarButtonItem *insertItem = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                   target:self
                                   action:@selector(insertItem)];
    
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                   target:self
                                   action:@selector(deleteItem)];
    
    UIBarButtonItem *toggleSizeItem = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                       target:self
                                       action:@selector(toggleItemSize)];
    
    self.navigationItem.rightBarButtonItems = @[toggleSizeItem, insertItem, deleteItem];
    
    self.pincher = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    
    [self.collectionView addGestureRecognizer:_pincher];
    
}

- (void)handlePinch:(UIPinchGestureRecognizer *)sender {
    if ([sender numberOfTouches] != 2)
        return;
    
    
    if (sender.state == UIGestureRecognizerStateBegan ||
        sender.state == UIGestureRecognizerStateChanged) {
        // Get the pinch points.
        CGPoint p1 = [sender locationOfTouch:0 inView:[self collectionView]];
        CGPoint p2 = [sender locationOfTouch:1 inView:[self collectionView]];
        
        // Compute the new spread distance.
        CGFloat xd = p1.x - p2.x;
        CGFloat yd = p1.y - p2.y;
        CGFloat distance = sqrt(xd*xd + yd*yd);
        
        // Update the custom layout parameter and invalidate.
        FJFlowLayoutWithAnimations* layout = (FJFlowLayoutWithAnimations*)[[self collectionView] collectionViewLayout];
        
        NSIndexPath *pinchedItem = [self.collectionView indexPathForItemAtPoint:CGPointMake(0.5*(p1.x+p2.x), 0.5*(p1.y+p2.y))];
        [layout resizeItemAtIndexPath:pinchedItem withPinchDistance:distance];
        [layout invalidateLayout];

    }
    else if (sender.state == UIGestureRecognizerStateCancelled ||
             sender.state == UIGestureRecognizerStateEnded){
        FJFlowLayoutWithAnimations* layout = (FJFlowLayoutWithAnimations*)[[self collectionView] collectionViewLayout];
        [self.collectionView
         performBatchUpdates:^{
            [layout resetPinchedItem];
         }
         completion:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertItem
{
    NSInteger randomSection = arc4random_uniform(_sectionCount);
    
    NSInteger item = [_itemCounts[randomSection] integerValue] + 1;
    _itemCounts[randomSection] = @(item);
    
    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:arc4random_uniform(item) inSection:randomSection]]];
}

- (void)deleteItem
{
    NSInteger randomSection = arc4random_uniform(_sectionCount);
    NSInteger item = [_itemCounts[randomSection] integerValue];

    if (item) {
        _itemCounts[randomSection] = @(item-1);
        [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:arc4random_uniform(item) inSection:randomSection]]];
    }
    else {
        NSInteger totalItems = 0;
        for (NSNumber *num in _itemCounts) {
            totalItems += [num integerValue];
        }
        if (totalItems) {
            [self deleteItem];
        }

    }

}

- (void)toggleItemSize
{

    if (_largeItems) {
        _largeItems = NO;
        [self.collectionView setCollectionViewLayout:_smallLayout animated:YES];
    }
    else {
        [self.collectionView setCollectionViewLayout:_largeLayout animated:YES];
        _largeItems = YES;
    }


}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
    
    if (indexPath) {
        FJDetailViewController *dvc = segue.destinationViewController;
        dvc.useLayoutToLayoutNavigationTransitions = YES;
        
        dvc.itemCount = [_itemCounts[indexPath.section] integerValue];
        dvc.color = indexPath.section;
        _selectedItem = indexPath.item;
    }
    
}


////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Collection View Data Source
////////////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _sectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_itemCounts[section] integerValue];
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SimpleCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSInteger itemCount = [self collectionView:collectionView numberOfItemsInSection:indexPath.section];
    CGFloat colorValue = 1.0-(indexPath.item+1.0)/(2*itemCount);
    
    cell.backgroundColor = [UIColor colorWithRed:(indexPath.section==0)?colorValue:0.0
                                           green:(indexPath.section==1)?colorValue:0.0
                                            blue:(indexPath.section==2)?colorValue:0.0
                                           alpha:1.0];
    
    return cell;
}



////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Navigation Controller Delegate
////////////////////////////////////////////////////////////////////////////////////////////

//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if ([viewController isKindOfClass:[FJDetailViewController class]]) {
//        FJDetailViewController *dvc = (FJDetailViewController*)viewController;
//       
//    }
//
//}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[FJDetailViewController class]]) {
        FJDetailViewController *dvc = (FJDetailViewController*)viewController;
        dvc.collectionView.dataSource = dvc;
        dvc.collectionView.delegate = dvc;
        [dvc.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_selectedItem inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
        _pincher.enabled = NO;
    }
    else if (viewController == self){
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        _pincher.enabled = YES;
    }
}
@end
