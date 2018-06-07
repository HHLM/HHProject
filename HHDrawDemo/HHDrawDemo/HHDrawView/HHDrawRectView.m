//
//  HHDrawRectView.m
//  HHDrawDemo
//
//  Created by Mac on 2018/6/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "HHDrawRectView.h"

@implementation HHDrawRectView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self addRect1];
    [self addRect2];
    [self addRect3];
    [self addRect4];
}

/** 通过直线画矩形 */
- (void)addRect4 {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(200, 150)];
    [path addLineToPoint:CGPointMake(350, 150)];
    [path addLineToPoint:CGPointMake(350, 250)];
    [path addLineToPoint:CGPointMake(200, 250)];
    [path addLineToPoint:CGPointMake(200, 150)];
    [[UIColor blueColor] set];
    [path stroke];
}
 /** 添加圆角矩形 */
- (void)addRect3 {
    
    /**
     
     UIRectCorner 哪个有圆角
     
     UIRectCornerTopLeft     = 1 << 0,
     UIRectCornerTopRight    = 1 << 1,
     UIRectCornerBottomLeft  = 1 << 2,
     UIRectCornerBottomRight = 1 << 3,
     UIRectCornerAllCorners  = ~0UL
     */
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 150, 150, 100) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(30, 15)];
    
    [[UIColor cyanColor] set];

    
    [path stroke];
}

/** 添加圆角矩形 */
- (void)addRect2 {
 
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(200, 20, 150, 100) cornerRadius:10];
    
    [[UIColor greenColor] set];
    
    [path stroke];
}

/** 添加矩形 */
- (void)addRect1 {
    UIBezierPath *paht = [UIBezierPath bezierPathWithRect:CGRectMake(20, 20, 150, 100)];
   
    [[UIColor redColor] set];
    
    /** 填充  默认会闭合曲线 */
//    [paht fill];
    
    
    [paht stroke];
}

@end
