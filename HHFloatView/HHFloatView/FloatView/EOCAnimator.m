//
//  EOCAnimator.m
//  微信浮窗一  公开课
//
//  Created by 八点钟学院 on 2018/6/5.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import "EOCAnimator.h"

@implementation EOCAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{

    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    /// A push B   toView：B.view
    
    if (self.operation == UINavigationControllerOperationPush) {  //push动画
        
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        toView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0.f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        
        UIView *containerView = transitionContext.containerView;
        
        [containerView addSubview:toView];
        
        [UIView animateWithDuration:0.5f animations:^{
            
            toView.frame = CGRectMake( 0.f, 0.f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:YES];  //移除fromView  以及 fromViewController
            
        }];
        
    } else {  //pop动画
        
        
        
    }    
    
}

@end
