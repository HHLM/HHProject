//
//  HHBezierPathView.m
//  HHDrawRectDemo
//
//  Created by LXH on 2017/6/27.
//  Copyright © 2017年 HHLM. All rights reserved.
//

#import "HHBezierPathView.h"

@implementation HHBezierPathView


/**
 // 创建基本路径
 + (instancetype)bezierPath;
 
 // 创建矩形路径
 + (instancetype)bezierPathWithRect:(CGRect)rect;
 
 // 创建椭圆路径
 + (instancetype)bezierPathWithOvalInRect:(CGRect)rect;
 
 // 创建圆角矩形
 + (instancetype)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius; 

 // 创建指定位置圆角的矩形路径
 + (instancetype)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
 
 // 创建弧线路径
 + (instancetype)bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;
 
 // 通过CGPath创建
 + (instancetype)bezierPathWithCGPath:(CGPathRef)CGPath;
 
 */


- (void)drawRect:(CGRect)rect {
    
    UIColor *color = [UIColor redColor];
    
    //设置颜色
    [color set];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //线条宽度
    path.lineWidth = 1.0;
    
    
    //线条终点类型
    path.lineCapStyle = kCGLineCapRound;
    
    //线条交点类型
    path.lineJoinStyle = kCGLineJoinMiter;
    
    //起点
    [path moveToPoint:CGPointMake(10, 80)];
    
    [path addLineToPoint:CGPointMake(10, 120)];
    [path addLineToPoint:CGPointMake(70, 120)];
    [path addLineToPoint:CGPointMake(70, 80)];

#if 0
    //最后一条线
    [path addLineToPoint:CGPointMake(10, 80)];
    
#else
    //封闭线条 得到最后一条线
    [path closePath];

#endif
    
    //在这以后的图形绘制超出当前路径范围则不可见
//    [path addClip];

    
    //连线
    [path stroke];
    
    //填充颜色
//    [path fill];
    
    //创建矩形
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRect:CGRectMake(100, 80, 60, 40)];
    
    path1.lineWidth = 2;
    
    path1.lineCapStyle = kCGLineCapRound;
    
    path1.lineJoinStyle = kCGLineJoinMiter;
    
    [[UIColor greenColor] set];
    
    [path1 fill];
    
    //创建椭圆
    

    path1 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(180, 80, 60, 40)];
    
    [path1 stroke];
    
    //创建圆形
    path1 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(260, 80, 40, 40)];
    
    [[UIColor purpleColor] set];
    
    [path1 fill];
    
    
    // 圆角矩形
    path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(320, 80, 60, 40) cornerRadius:5];
    
    [path1 stroke];
    
    //圆
    path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(30, 160) radius:20 startAngle:0 endAngle:M_PI *2 clockwise:YES];
    
    [path1 stroke];
    
    //圆弧
    path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(90, 160) radius:20 startAngle:0 endAngle:M_PI clockwise:YES];
    
    
    [path1 closePath];
    /** 
     center：弧线圆心坐标
     radius：弧线半径
     startAngle：弧线起始角度
     endAngle：弧线结束角度
     clockwise：是否顺时针绘制
     */
    
    [path1 stroke];
    
    
    //扇形
    
    //起点
    [path1 moveToPoint:CGPointMake(150, 180)];
    
    //
    [path1 addArcWithCenter:CGPointMake(150, 160) radius:20 startAngle:0 endAngle:M_PI clockwise:0];
    
    [[UIColor cyanColor] set];
    
    [path1 closePath];
    
    [path1 stroke];
    
//    [path1 fill];
    
    //圆弧
    path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(210, 160) radius:20 startAngle:0 endAngle:M_PI/180 * 135 clockwise:NO];
    
    [path1 stroke];
    
    // 可以去掉任意角的矩形
    path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(280, 140, 80, 40) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(20, 20)];
    
    
    
    //用指定的混合模式和透明度来填充路径包围的区域
    [path1 fillWithBlendMode:kCGBlendModeColorBurn alpha:0.5];
    
    [path1 stroke];
    
    [[UIColor magentaColor] set];
    [path1 fill];
    
    
//    CGAffineTransformIdentity
    CGPathRef ref = CGPathCreateWithEllipseInRect(CGRectMake(10, 200, 60, 40), &CGAffineTransformIdentity);
    
    path1 = [UIBezierPath bezierPathWithCGPath:ref];
    [path1 stroke];
    
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    
    path2.lineWidth = 2;
    
    //贝塞尔曲线一
    [path2 moveToPoint:CGPointMake(90, 220)];
    
    [path2 addCurveToPoint:CGPointMake(250, 220) controlPoint1:CGPointMake(140, 180) controlPoint2:CGPointMake(200, 250)];
    
    [path2 stroke];
    
    //贝塞尔曲线二
    
    [path2 moveToPoint:CGPointMake(270, 200)];
    
    [path2 addQuadCurveToPoint:CGPointMake(400, 220) controlPoint:CGPointMake(340, 280)];
    
    [path2 stroke];
    
    // 点(100,100)是否在区域内
    [path2 containsPoint:CGPointMake(100, 100)];
    
    
    
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    
    path3.lineWidth = 1;
    
    //设置曲线
    CGFloat lengths[] = {5,5};
    [path3 setLineDash:lengths count:1 phase:0];
    
    [path3 moveToPoint:CGPointMake(10, 250)];
    
    [path3 addLineToPoint:CGPointMake(300, 250)];
    
    [path3 stroke];
    
    NSInteger count[] = {3,3};
    [path3 getLineDash:lengths count:count phase:lengths];
    
    [path3 moveToPoint:CGPointMake(10, 260)];
    
    [path3 addLineToPoint:CGPointMake(300, 250)];
    
     //按指定的混合模式和透明度进行画线
    [path3 strokeWithBlendMode:kCGBlendModeColor alpha:0.1];
    
    [path3 stroke];
    
    //仿射变换
    [path3 applyTransform:CGAffineTransformIdentity];
    
    
    
    
    

    
    
    
    
}


@end
