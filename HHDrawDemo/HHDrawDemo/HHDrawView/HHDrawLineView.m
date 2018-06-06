//
//  HHDrawLineView.m
//  HHDrawDemo
//
//  Created by Mac on 2018/6/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "HHDrawLineView.h"

@implementation HHDrawLineView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        NSLog(@"%s",__func__);
    }
    return self;
}

/**
    1、当view要显示的时候 才会调用绘制图形的方法
    2、rect 是当前控件的bounds
 */

- (void)drawRect:(CGRect)rect {
    
     NSLog(@"%s",__func__);
    [self addLine1];
    [self addLine2];
    [self addLine3];
}

- (void)addLine3 {
    
    /** 贝塞尔路径 */
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    /** 设置起点  */
    [path moveToPoint:CGPointMake(20, 60)];
    
    /** 添加直线 */
    [path addLineToPoint:CGPointMake(350, 60)];
    
    /** 上个线的终端 再加一条线 */
    [path addLineToPoint:CGPointMake(350, 10)];
    
#if 2  //其他设置
    
    /** 设置线条尖端类型 */
    [path setLineCapStyle:kCGLineCapRound];
    
    /** 设置线条宽度 */
    [path setLineWidth:2];
    
#endif
    
    /** 绘制路径 */
    [path stroke];
    
}

- (void)addLine2 {
    
    /** 1、获取图形上下文 */
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    /**2、 描述路径 绘制 并添加到图形上下文*/
    CGContextMoveToPoint(ctx, 30, 40);
    
    CGContextAddLineToPoint(ctx, 300, 40);
    
    /** 3、渲染到试图 */
    
    CGContextSetRGBStrokeColor(ctx, 0, 1, 0, 1);
    
    CGContextStrokePath(ctx);
}

- (void)addLine1 {
    
    /** 1、获取图形上下文 */
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    /** 2、描述路径  绘制路径 */
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    CGPathMoveToPoint(pathRef, nil, 20, 20);
    
    CGPathAddLineToPoint(pathRef, nil, 250, 20);
    
    
    /** 3、把路径添加到图形上下文 */
    
    CGContextAddPath(ctx, pathRef);
    
    /** 4、把图形上下文渲染到试图上展示 */
    
    //渲染的颜色
    CGContextSetRGBStrokeColor(ctx, 1, 0, 0, 1);
    
    CGContextStrokePath(ctx);
    
}

@end
