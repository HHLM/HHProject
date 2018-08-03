//
//  HHAnimation.m
//  HHWeChatFloatView
//
//  Created by Mac on 2018/7/5.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHAnimation.h"
#import "HHFiles.h"

#define AnimationDuration 0.25

@interface HHAnimation()<CAAnimationDelegate>
@property (nonatomic, strong) id<UIViewControllerContextTransitioning>transitionContext;
@end

@implementation HHAnimation
/** 动画过度时间 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return AnimationDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    self.transitionContext = transitionContext;
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
   
    
    UIView *contView = [transitionContext containerView];
    [contView addSubview:toVC.view];
    [contView addSubview:fromVC.view];
    UIView *containerView  = [transitionContext containerView];
    CGRect floatBallRect = self.floatView.frame;
    if (_operation == UINavigationControllerOperationPush) {
        /**
         UITransitionContextFromViewControllerKey
         
         UITransitionContextToViewControllerKey
         */

        [containerView addSubview:toVC.view];
        
        
        //动画开始样式
        UIBezierPath *starPath = [UIBezierPath bezierPathWithRoundedRect:floatBallRect cornerRadius:floatBallRect.size.width/2];
        //动画结束样式
        UIBezierPath *endPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0,kDeviecWidth, kDeviecHeight) cornerRadius:floatBallRect.size.width/2];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = endPath.CGPath;
        toVC.view.layer.mask = layer;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
        animation.fromValue = (__bridge id)(starPath.CGPath);
        animation.toValue = (__bridge id)((endPath.CGPath));
        animation.duration = AnimationDuration;
        animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.delegate = self;
        [layer addAnimation:animation forKey:@"path"];
        
        [UIView animateWithDuration:AnimationDuration animations:^{
            self.floatView.alpha = 0;
        }];
    }else if (_operation == UINavigationControllerOperationPop) {
    
        if (_isInteractive) {
            
            UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
            [containerView addSubview:toView];
            
            UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
            [containerView bringSubviewToFront:fromView];
            
            [UIView animateWithDuration:0.25f animations:^{
                
                fromView.frame = CGRectOffset(fromView.frame, [UIScreen mainScreen].bounds.size.width, 0.f);
                
            } completion:^(BOOL finished) {
                
                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                
                if (!transitionContext.transitionWasCancelled) {
        
                    
                }
                
            }];
            return;
        }
        
        UIBezierPath *starPath =  [UIBezierPath bezierPathWithRoundedRect:floatBallRect cornerRadius:floatBallRect.size.height/2];
        
        UIBezierPath *endPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0,kDeviecWidth, kDeviecHeight) cornerRadius:floatBallRect.size.width/2];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = starPath.CGPath;
        fromVC.view.layer.mask = layer;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
        animation.toValue = (__bridge id)(starPath.CGPath);
        animation.fromValue = (__bridge id)((endPath.CGPath));
        animation.duration = AnimationDuration;
        animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.delegate = self;
        [layer addAnimation:animation forKey:@"path"];
        
        [UIView animateWithDuration:AnimationDuration animations:^{
            self.floatView.alpha = 1;
        }];
    }

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.transitionContext completeTransition:YES];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

@end
