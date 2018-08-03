//
//  HHManager.m
//  HHWeChatFloatView
//
//  Created by Mac on 2018/8/3.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHManager.h"
#import "HHFiles.h"
#import "NSObject+Ext.h"
#import "HHAnimation.h"
#import "HHInteractiveTransition.h"
@interface HHManager()<UIGestureRecognizerDelegate,UINavigationControllerDelegate,HHFloatViewDelegate>
@property (nonatomic, strong) CADisplayLink  *link;
@property (nonatomic, strong) UIGestureRecognizer *endGesture;
@property (nonatomic, strong) HHInteractiveTransition *interactiveTransition;
@end
@implementation HHManager
+ (HHManager *)shareManager {
    static dispatch_once_t onceToken;
    static HHManager *manger = nil;
    dispatch_once(&onceToken, ^{
        manger = [[HHManager alloc] init];
        manger.floatArray = [NSMutableArray array];
        manger.currentNavigationController.interactivePopGestureRecognizer.delegate = manger;
        manger.currentNavigationController.delegate = manger;
    });
    return manger;
}

- (CADisplayLink *)link {
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(panBack:)];
    }return _link;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.currentNavigationController.viewControllers.count > 1) { //多层才可以滑动
        [self addBeginScreenPanBackGursture:gestureRecognizer];
        return YES;
    }
    return NO; //不可以滑动
}
- (void)addBeginScreenPanBackGursture:(UIGestureRecognizer *)gestureRecognizer {
    /** 滑动返回时候判断当前VC是不是 需要展示浮窗的那个VC */
    if ([self.floatArray containsObject:NSStringFromClass([[self currentViewConroller] class])] && !self.showFloat) {
        [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        /** 给浮窗VC赋值 */
        self.floatViewController = self.currentViewConroller;
        /** 展示出来 提示展示浮窗窗口View */
        [self.keyWindow addSubview:self.floatAlert];
        self.endGesture = gestureRecognizer;
    }
}

- (void)panBack:(CADisplayLink *)link {
    UIView *showView = self.keyWindow;
    if (self.endGesture.state == UIGestureRecognizerStateBegan) {
        
    }else if (self.endGesture.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [self.endGesture locationInView:showView];
        [self.floatAlert setHeightLight:NO];
        NSLog(@"-------:%f",point.x);
        CGFloat x = MAX(kDeviecWidth-point.x, kDeviecWidth - kFloatAlertWidth);
        CGFloat y = MAX(kDeviecHeight-point.x, kDeviecHeight - kFloatAlertWidth);
        [self.floatAlert setFrame:CGRectMake(x, y, kFloatAlertWidth, kFloatAlertWidth)];
    }else if (self.endGesture.state == UIGestureRecognizerStateEnded) {
        
    }else if (self.endGesture.state == UIGestureRecognizerStatePossible) {
        [self.link invalidate];
        self.link = nil;
        /** 最后停留的点在 floatAlert范围内 把浮窗展示出来 */
        if (CGRectContainsPoint(self.floatAlert.frame, [self.endGesture locationInView:showView])) {
            [self.floatView setFrame:self.lastFrame];
            [self.keyWindow addSubview:self.floatView];
            self.floatAlert.alpha = 1;
            self.showFloat = YES;
        }
         [self.floatAlert setFrame:CGRectMake(kDeviecWidth, kDeviecHeight, kFloatAlertWidth, kFloatAlertWidth)];
    }
}

#pragma mark -- method
- (void)showFloatView {
    [self.keyWindow addSubview:self.floatView];
    [self.floatView setFrame:self.lastFrame];
    self.showFloat = YES;
}
- (void)dismissFloatView {
    [_floatView removeFromSuperview];
    _floatView = nil;
}
#pragma mark -- deletate
- (void)hh_floatViewClicked:(HHFloatView *)floatView {
    NSLog(@"点击出现showViewController");
    _interactiveTransition = [HHInteractiveTransition new];
    _interactiveTransition.curPoint = self.floatView.frame.origin;
    self.currentNavigationController.delegate = self;
    [_interactiveTransition transitionToViewController:self.floatViewController];
    [[self currentNavigationController] pushViewController:self.floatViewController animated:YES];
    
    
    
}
- (void)hh_floatViewTouchsBegan:(HHFloatView *)floatView {
    self.lastFrame = self.floatView.frame;
}
- (void)hh_floatViewTouchsMoved:(HHFloatView *)floatView {
    [self.keyWindow addSubview:self.floatAlert];
    [self.floatAlert setHeightLight:YES];
    [self.keyWindow bringSubviewToFront:self.floatView];
    [self.floatAlert setFrame:CGRectMake(kDeviecWidth-kFloatAlertWidth, kDeviecHeight-kFloatAlertWidth, kFloatAlertWidth, kFloatAlertWidth)];
}
- (void)hh_floatViewTouchsEnded:(HHFloatView *)floatView {
    if (CGRectEqualToRect(self.floatAlert.frame, CGRectMake(kDeviecWidth-kFloatAlertWidth, kDeviecHeight-kFloatAlertWidth, kFloatAlertWidth, kFloatAlertWidth))) {
        CGRect frame = self.floatAlert.frame;
        [UIView animateWithDuration:0.2 animations:^{
            self.floatAlert.frame = CGRectMake(kDeviecWidth, kDeviecHeight, kFloatAlertWidth, kFloatAlertWidth);
            /** 当把浮窗移到弹窗view上 移除浮窗 */
            if (CGRectContainsRect(frame, floatView.frame)) {
                [floatView removeFromSuperview];
                self.showFloat = NO;
                //把代理置为nil 防止其他页面的压栈出栈有动画
                //添加转场动画
            }else {
//                self.lastFrame = self.floatView.frame;
            }
        }];
    }
}

#pragma mark -- Method delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
}
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  {
    
    //只有 HHShowViewController 这个页面才有自定义动画
    
    UIViewController *vc = self.floatViewController;
    
    if (vc) {
        HHAnimation *animation = [[HHAnimation alloc] init];
        animation.operation = operation;
        animation.floatView = self.floatView;
        animation.isInteractive = _interactiveTransition.isInteractive;
        if (operation == UINavigationControllerOperationPop) {
            if (fromVC != vc) {
                return nil;
            }
            return animation;
            
        }else if(operation == UINavigationControllerOperationPush) {
            if (toVC != vc) {
                return nil;
            }return animation;
        }
        
        return animation;
    }else {
        return nil;
    }
}
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    
    return _interactiveTransition.isInteractive?_interactiveTransition:nil;
    
}

#pragma mark -- UI
- (HHFloatView *)floatView {
    if (!_floatView) {
        _floatView = [[HHFloatView alloc] initWithFrame:CGRectMake(15, 100, kBallWidth, kBallWidth)];
        _floatView.delegate = self;
        _lastFrame = _floatView.frame;
    }return _floatView;
}
- (HHFloatAlertView *)floatAlert {
    if (!_floatAlert) {
        _floatAlert = [[HHFloatAlertView alloc] initWithFrame:CGRectMake(kDeviecWidth, kDeviecHeight, kFloatAlertWidth, kFloatAlertWidth)];
    }return _floatAlert;
}
@end
