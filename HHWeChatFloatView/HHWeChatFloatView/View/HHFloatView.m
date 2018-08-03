//
//  HHFloatView.m
//  HHWeChatFloatView
//
//  Created by Mac on 2018/8/3.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHFloatView.h"



#import "HHFiles.h"
#import "HHAnimation.h"
#import "HHFloatAlertView.h"
#import "HHShowViewController.h"


@interface HHFloatView()<UINavigationControllerDelegate,UIGestureRecognizerDelegate,CAAnimationDelegate>
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *edgePan;
@property (nonatomic, strong) CADisplayLink *link;
@end

@implementation HHFloatView
{
    CGPoint startPoint; //起始坐标
    CGPoint pointInSelf; //浮窗内的坐标
    CGRect  lastFrame;   //移除前的最后停留位置
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //设置图片
        self.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"wechat_link"].CGImage);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


/** 点击 */
- (void)clicked {
    NSLog(@"响应了点击事件");
    if (_delegate && [_delegate respondsToSelector:@selector(hh_floatViewClicked:)]) {
        [_delegate hh_floatViewClicked:self];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_delegate && [_delegate respondsToSelector:@selector(hh_floatViewTouchsBegan:)]) {
        [_delegate hh_floatViewTouchsBegan:self];
    }
    
    UITouch *touch = [touches anyObject];
    startPoint = [touch locationInView:self.superview];
    pointInSelf = [touch locationInView:self];
    //NSLog(@"自身内的坐标：%@",NSStringFromCGPoint(pointInSelf));
    //NSLog(@"父视图的坐标：%@",NSStringFromCGPoint(startPoint));
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_delegate && [_delegate respondsToSelector:@selector(hh_floatViewTouchsMoved:)]) {
        [_delegate hh_floatViewTouchsMoved:self];
    }
    
    /** 当前坐标 */
    CGPoint currentPoint = [[touches anyObject] locationInView:self.superview];
    
    //NSLog(@"%@",NSStringFromCGPoint(currentPoint));
    
    /** 获取到当前浮窗的中心 */
    CGFloat centerX = currentPoint.x + (self.width/2 - pointInSelf.x);
    CGFloat centerY = currentPoint.y + (self.height/2 - pointInSelf.y);
    
    //避免 超过屏幕
    CGFloat x =  MAX(kBallWidth/2,MIN(centerX, self.superview.width - kBallWidth/2));
    CGFloat y =  MAX(kBallWidth/2 + 20,MIN(centerY, self.superview.height - kBallWidth/2-10));
    
    CGPoint center = CGPointMake(x,y);
    self.center = center;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    
    CGPoint currentPoint = [[touches anyObject] locationInView:self.superview];
    
    //判断是不是点击
    if (CGPointEqualToPoint(startPoint,currentPoint)) { }
    
    //判断距离哪边近
    CGFloat margin = self.center.x;
    
    //回到左边
    if (margin < kDeviecWidth / 2.0) {
        [UIView animateWithDuration:0.2 animations:^{
            self.center = CGPointMake(kBallWidth / 2.0 + 10, self.center.y);
        }];
    }else { //回到右边
        [UIView animateWithDuration:0.2 animations:^{
            self.center = CGPointMake(kDeviecWidth - (kBallWidth / 2.0 + 10), self.center.y);
        }];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(hh_floatViewTouchsEnded:)]) {
        [_delegate hh_floatViewTouchsEnded:self];
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
    if (operation == UINavigationControllerOperationPop) {
        if (![fromVC isKindOfClass:[NSClassFromString(@"HHShowViewController") class]]) {
            return nil;
        }
        
    }else if(operation == UINavigationControllerOperationPush) {
        if (![toVC isKindOfClass:[NSClassFromString(@"HHShowViewController") class]]) {
            return nil;
        }else {

        }
    }
    
    HHAnimation *animation = [[HHAnimation alloc] init];
    animation.operation = operation;
    return animation;
    
}

@end
