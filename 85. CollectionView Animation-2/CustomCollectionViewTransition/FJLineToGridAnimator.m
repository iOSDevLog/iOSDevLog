//
//  FJLineToGridAnimator.m
//  CustomCollectionViewTransition
//
//  Created by Engin Kurutepe on 01/05/14.
//  Copyright (c) 2014 Fifteen Jugglers Software. All rights reserved.
//

#import "FJLineToGridAnimator.h"

@interface FJLineToGridAnimator ()

@property (nonatomic, strong) UICollectionViewTransitionLayout *transitionLayout;
@property (nonatomic) NSTimeInterval startTime;
@property (nonatomic) NSTimeInterval endTime;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, strong) UICollectionView *toCollectionView;

@end

@implementation FJLineToGridAnimator


////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Animated Transitioning
////////////////////////////////////////////////////////////////////////////////////////////////

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.6;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *inView = [transitionContext containerView];
    UICollectionViewController *fromVC = (UICollectionViewController*) [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView         = [fromVC view];
    UICollectionViewController *toVC   = (UICollectionViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;
    self.toCollectionView = [toVC collectionView];
    
    CGRect initialRect = [inView.window convertRect:_fromCollectionView.frame fromView:_fromCollectionView.superview];
    CGRect finalRect   = [transitionContext finalFrameForViewController:toVC];

    UICollectionViewFlowLayout *toLayout = (UICollectionViewFlowLayout*) _toCollectionView.collectionViewLayout;

    UICollectionViewFlowLayout *currentLayout = (UICollectionViewFlowLayout*) _fromCollectionView.collectionViewLayout;
    UICollectionViewFlowLayout *currentLayoutCopy = [[UICollectionViewFlowLayout alloc] init];
    
    currentLayoutCopy.itemSize = currentLayout.itemSize;
    currentLayoutCopy.sectionInset = currentLayout.sectionInset;
    currentLayoutCopy.minimumLineSpacing = currentLayout.minimumLineSpacing;
    currentLayoutCopy.minimumInteritemSpacing = currentLayout.minimumInteritemSpacing;
    currentLayoutCopy.scrollDirection = currentLayout.scrollDirection;
    
    [self.fromCollectionView setCollectionViewLayout:currentLayoutCopy animated:NO];
    
    UIEdgeInsets contentInset = _toCollectionView.contentInset;

    CGFloat oldBottomInset = contentInset.bottom;
    contentInset.bottom = CGRectGetHeight(finalRect)-(toLayout.itemSize.height+toLayout.sectionInset.bottom+toLayout.sectionInset.top);

    self.toCollectionView.contentInset = contentInset;
    [self.toCollectionView setCollectionViewLayout:currentLayout animated:NO];
    toView.frame = initialRect;
    [inView insertSubview:toView aboveSubview:fromView];
    
    [UIView
     animateWithDuration:[self transitionDuration:transitionContext]
     delay:0
     options:UIViewAnimationOptionBeginFromCurrentState
     animations:^{
         toView.frame = finalRect;
         [_toCollectionView
          performBatchUpdates:^{
              [_toCollectionView setCollectionViewLayout:toLayout animated:NO];
          }
          completion:^(BOOL finished) {
              _toCollectionView.contentInset = UIEdgeInsetsMake(contentInset.top,
                                                                contentInset.left,
                                                                oldBottomInset,
                                                                contentInset.right);
          }];
  
     } completion:^(BOOL finished) {
         [transitionContext completeTransition:YES];
     }];
    


}

@end