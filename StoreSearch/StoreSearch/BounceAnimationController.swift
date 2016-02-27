//
//  BounceAnimationController.swift
//  StoreSearch
//
//  Created by iosdevlog on 16/2/27.
//  Copyright © 2016年 iosdevlog. All rights reserved.
//

import UIKit

class BounceAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        if let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey),
            let containerView = transitionContext.containerView() {
                toView.frame = transitionContext.finalFrameForViewController(toViewController)
                containerView.addSubview(toView)
                toView.transform = CGAffineTransformMakeScale(0.7, 0.7)
                
                UIView.animateKeyframesWithDuration(transitionDuration(transitionContext), delay: 0, options: .CalculationModeCubic, animations: {
                    UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.334, animations: {
                        toView.transform = CGAffineTransformMakeScale(1.2, 1.2)
                    })
                    UIView.addKeyframeWithRelativeStartTime(0.334, relativeDuration: 0.333, animations: {
                        toView.transform = CGAffineTransformMakeScale(0.9, 0.9)
                    })
                    UIView.addKeyframeWithRelativeStartTime(0.666, relativeDuration: 0.333, animations: {
                        toView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    })
                    }, completion: { finished in
                        transitionContext.completeTransition(finished)
                })
        }
    }
}