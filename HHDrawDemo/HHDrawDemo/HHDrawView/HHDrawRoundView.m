//
//  HHDrawRoundView.m
//  HHDrawDemo
//
//  Created by Mac on 2018/6/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "HHDrawRoundView.h"

@implementation HHDrawRoundView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self addRound1];
    [self addRound2];
    [self addRound3];
    [self addRound4];
}
- (void)addRound1 {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 20, 200, 200) cornerRadius:100];
    [[UIColor greenColor] set];
    [path stroke];
//    [path fill];
}
- (void)addRound2 {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(250, 120) radius:100 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [[UIColor redColor] set];
    [path stroke];
    [path fill];
}
- (void)addRound3 {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 160, 200, 200) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(100, 100)];
    [[UIColor blueColor] set];
    [path stroke];
//    [path fill];
}
/**
 类似于 addRound1 的方式
 */
- (void)addRound4 {
    /** 获取图形上下文 */
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctx, 200, 400, 100, 0, M_PI *2, 1);
    [[UIColor cyanColor] setStroke];
    CGContextStrokePath(ctx);
}

@end
