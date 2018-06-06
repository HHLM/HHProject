//
//  EOCWeChatFloatingBtn.m
//  微信浮窗一  公开课
//
//  Created by 八点钟学院 on 2018/6/5.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import "EOCWeChatFloatingBtn.h"
#import "EOCSemiCircleView.h"
#import "EOCNextViewController.h"
#import "EOCAnimator.h"

@interface EOCWeChatFloatingBtn () <UINavigationControllerDelegate>{
    
    CGPoint lastPoint;
    CGPoint pointInSelf;
    
}


@end

@implementation EOCWeChatFloatingBtn
#define fixSpace 160.f
static EOCWeChatFloatingBtn *floatingBtn;
static EOCSemiCircleView *semiCircleView;

+ (void)show {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        floatingBtn = [[EOCWeChatFloatingBtn alloc] initWithFrame:CGRectMake(0, 200.f, 60.f, 60.f)];
        semiCircleView = [[EOCSemiCircleView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, 160.f, 160.f)];
        
    });
    
    ///下面添加的次序不能乱
    if (!semiCircleView.superview) {
        
        [[UIApplication sharedApplication].keyWindow addSubview:semiCircleView];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:semiCircleView];
        
    }
    
    if (!floatingBtn.superview) {
        
        [[UIApplication sharedApplication].keyWindow addSubview:floatingBtn];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:floatingBtn];
        
    }
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    //给自己赋予图片
    self.layer.contents = (__bridge id)[UIImage imageNamed:@"WebView_Minimize_Float_IconHL"].CGImage;
    
    return self;
    
}


#pragma mark - UITouch 事件

//1、上下拖动
//2、左右拖动
//3、能够点击

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.superview];   //存储刚开始触摸的时候  的位置坐标
    pointInSelf = [touch locationInView:self];
    
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    /// 随着self的移动，  semiCircleView  需要有展开动画
    if (CGRectEqualToRect(semiCircleView.frame, CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, fixSpace, fixSpace))) {
        
        ///我才展开
        [UIView animateWithDuration:0.2f animations:^{
            
            semiCircleView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - fixSpace, [UIScreen mainScreen].bounds.size.height - fixSpace, fixSpace, fixSpace);
            
        }];
        
    }
    
    ///  我需要根据你的移动，改变self的坐标   上下左右 拖动 都不能超过屏幕的边缘
    
    /// 此时self的center中心点坐标
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.superview];
    
    CGFloat centerX = currentPoint.x + (self.frame.size.width/2 - pointInSelf.x);
    CGFloat centerY = currentPoint.y + (self.frame.size.height/2 - pointInSelf.y);
    
    CGFloat x = MAX(30.f, MIN([UIScreen mainScreen].bounds.size.width-30.f, centerX));   //x坐标应该介于  30.f  和  [UISCreen mainScreen].bounds.size.width-30.f
    CGFloat y = MAX(30.f, MIN([UIScreen mainScreen].bounds.size.height-30.f, centerY));
    
    self.center = CGPointMake(x, y);
    
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.superview];
    
    if (CGPointEqualToPoint(lastPoint, currentPoint)) {
        
        /// 点击跳转
        UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        nav.delegate = self;
        EOCNextViewController *nextViewCtrl = [[EOCNextViewController alloc] init];
        
        [nav pushViewController:nextViewCtrl animated:YES];
        
        return;
        
    }
    
    /// 收缩动画
    if (CGRectEqualToRect(semiCircleView.frame, CGRectMake([UIScreen mainScreen].bounds.size.width - fixSpace, [UIScreen mainScreen].bounds.size.height - fixSpace, fixSpace, fixSpace))) {
        
        CGRect frame = semiCircleView.frame;
        
        [UIView animateWithDuration:0.2f animations:^{
           
            semiCircleView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, fixSpace, fixSpace);
            
            if (CGRectContainsRect(frame, self.frame)) {
                
                [self removeFromSuperview];
                
            }
            
        }];
        
    }
    
    ///左右判断   此时self的坐标离哪边近   就回弹到哪边
    CGFloat leftMargin = self.center.x;
    CGFloat rightMargin = [UIScreen mainScreen].bounds.size.width - leftMargin;
    
    if (leftMargin < rightMargin) {  //回弹到左边
        
        [UIView animateWithDuration:0.2f animations:^{
           
            self.center = CGPointMake(40.f, self.center.y);
            
        }];
        
    } else {   //回弹到右边
        
        [UIView animateWithDuration:0.2f animations:^{
           
            self.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 40.f, self.center.y);
            
        }];
        
    }
    
    
    
}


#pragma mark - UINavigationControllerDelegate method
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    
    EOCAnimator *animator = [EOCAnimator new];
    animator.operation = operation;
    
    return animator;
    
}


//交互式转场动画
//- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
//                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
//
//
//
//}


@end
