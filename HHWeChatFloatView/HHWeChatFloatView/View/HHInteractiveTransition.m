//
//  HHInteractiveTransition.m
//  HHWeChatFloatView
//
//  Created by Mac on 2018/8/3.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHInteractiveTransition.h"
#import "NSObject+Ext.h"
#import "HHBallView.h"

@interface HHInteractiveTransition()
{
    
    UIViewController *presentedViewController;
    BOOL shouldComplete;
    CGFloat transitionX;
    
}
@end

@implementation HHInteractiveTransition

- (void)transitionToViewController:(UIViewController *)toViewController {
    presentedViewController = toViewController;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [toViewController.view addGestureRecognizer:panGesture];
}
- (void)panAction:(UIPanGestureRecognizer *)gesture {
    
    UIView *floatingBtn = [UIApplication sharedApplication].keyWindow.subviews.lastObject;
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    switch (gesture.state) {
            
        case UIGestureRecognizerStateBegan:
            
            _isInteractive = YES;
            
            [nav popViewControllerAnimated:YES];
            
            break;
            
        case UIGestureRecognizerStateChanged: {
            
            //监听当前滑动的距离
            CGPoint transitionPoint = [gesture translationInView:presentedViewController.view];
            
            CGFloat ratio = transitionPoint.x/[UIScreen mainScreen].bounds.size.width;
            
            transitionX = transitionPoint.x;
            
            NSLog(@"--------:%f",transitionX);
            ///获得floatingBtn，改变它的alpha值
            
            floatingBtn.alpha = ratio;
            
            if (ratio >= 0.5) {
                
                shouldComplete = YES;
                
            } else {
                
                shouldComplete = NO;
                
            }
            
            [self updateInteractiveTransition:ratio];
            
        }
            
            break;
        case UIGestureRecognizerStateEnded: {
             _isInteractive = NO;
        }
        case UIGestureRecognizerStateCancelled: {
            
            if (shouldComplete) {
                /// 添加动画
                ///截屏
                UIView *fromView = presentedViewController.view;
                
                HHBallView *theView = [[HHBallView alloc] initWithFrame:fromView.bounds];
                /** 开启位图图形上下文 */
                UIGraphicsBeginImageContext(fromView.bounds.size);
                /** 图层渲染到图形上下文上 */
                [fromView.layer renderInContext:UIGraphicsGetCurrentContext()];
                /** 获取图片 */
                UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
                theView.imgView.image = image;
                /** 关闭图形上下文 */
                UIGraphicsEndImageContext();
                
                CGRect fromRect = fromView.frame;
                
                fromView.frame = CGRectZero;
                
                [fromView.superview addSubview:theView];
                
                [theView startAnimationForView:theView fromRect:CGRectMake(transitionX, 0.f, fromRect.size.width, fromRect.size.height) toRect:CGRectMake(_curPoint.x, _curPoint.y, 60.f, 60.f)];
                
                [self finishInteractiveTransition];
                
                nav.delegate = nil;  //这个需要设置，而且只能在这里设置，不能在外面设置
                
            } else {
                
                floatingBtn.alpha = 0.f;
                [self cancelInteractiveTransition];
                
            }
                
            
            _isInteractive = NO;
            
        }
            break;
        default:
            break;
    }
    
}

@end
