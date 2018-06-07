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
    [[UIColor yellowColor] set];
    [self addLine1];
    [self addLine2];
    [self addLine3];
    [self addLine4];
    [self addLine5];
    [self addLine6];
    [self addLine7];
    [self addLine8];
}


- (void)addLine8 {
    /** 设置中心点 */
    CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/2, 400);
    /** 路径 */
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:150 startAngle:-M_PI_4 endAngle:-M_PI_4 * 3 clockwise:NO];
    
    [path addLineToPoint:center];

    [[UIColor purpleColor] set];;
    /** 填充 */
    [path fill];
}


/** 画一个扇形 */

- (void)addLine7 {
    /** 设置中心点 */
    CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/2, 400);
    /** 路径 */
    
    /**
     Center ：中心点坐标
     radius : 半径大小
     startAngle ： 开始弧度大小 中心坐标的 正右边是弧度为0的地方 逆时针为负 顺时针为正
     endAngle：结束弧度大小
     clockwise：绘图方向 YES顺时针 NO逆时针
     */
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:150 startAngle:M_PI_4 endAngle:M_PI_4 * 3 clockwise:YES];
    
    [path addLineToPoint:center];
    
    /** 封闭路径 */
    [path closePath];
    /** 线条宽度 */
    path.lineWidth = 3;
    /** 设置颜色 */
    [[UIColor cyanColor] set];;
    /** 渲染 */
    [path stroke];
}

/** 画一条圆弧 */

- (void)addLine6 {
    /** 设置中心点 */
    CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/2, 300);
    /** 路径 */
    
    /**
     Center ：中心点坐标
     radius : 半径大小
     startAngle ： 开始弧度大小 中心坐标的 正右边是弧度为0的地方 逆时针为负 顺时针为正
     endAngle：结束弧度大小
     clockwise：绘图方向 YES顺时针 NO逆时针
     */
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:150 startAngle:-M_PI_2 endAngle:M_PI_2 * 3/2 clockwise:NO];
    /** 线条宽度 */
    path.lineWidth = 3;
    /** 设置颜色 */
    [[UIColor redColor] set];;
    /** 渲染 */
    [path stroke];
}

/** 画一条三次曲线 */
- (void)addLine5 {
    /** 1.获取图形上下文 */
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    /** 2.设置路径 并添加到图上下文 */
    CGContextMoveToPoint(ctx, 20, 200);
    
    /** 3次贝塞尔曲线
     CGContextRef  _Nullable c : 图形上下文
     cpx1: 控制点1 x坐标
     cpy1: 控制点1 y坐标
     
     cpx2: 控制点1 x坐标
     cpy2: 控制点1 y坐标
     x: 结束点x坐标
     y: 结束点y坐标
     CGContextAddCurveToPoint(CGContextRef  _Nullable c, CGFloat cp1x, CGFloat cp1y, CGFloat cp2x, CGFloat cp2y, CGFloat x, CGFloat y)
     */
    CGContextAddCurveToPoint(ctx,100, 250, 200, 100, 350, 300);
    
    /** 3.渲染到视图上 */
    CGContextStrokePath(ctx);
}

/** 画一条二次曲线 */
- (void)addLine4 {
    
    /** 1.获取图形上下文 */
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    /** 2.设置路径 并添加到图上下文 */
    CGContextMoveToPoint(ctx, 50, 150);
    
    /** 二次贝塞尔曲线
     CGContextRef  _Nullable c : 上下文
     cpx: 控制点x坐标
     cpy: 控制点y坐标
     x: 结束点x坐标
     y: 结束点y坐标
     CGContextAddQuadCurveToPoint(CGContextRef  _Nullable c, CGFloat cpx, CGFloat cpy, CGFloat x, CGFloat y)
     */
    CGContextAddQuadCurveToPoint(ctx, 150, 50, 300, 150);
    
    /** 3.渲染到视图上 */
    CGContextStrokePath(ctx);
    
}

- (void)addLine3 {
    
    /** 贝塞尔路径 */
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    /** 设置起点  */
    [path moveToPoint:CGPointMake(20, 100)];
    
    /** 添加直线 */
    [path addLineToPoint:CGPointMake(350, 120)];
    
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
    CGContextMoveToPoint(ctx, 30, 60);
    
    CGContextAddLineToPoint(ctx, 300, 80);
    
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
