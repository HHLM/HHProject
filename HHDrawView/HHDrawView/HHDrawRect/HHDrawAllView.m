//
//  HHDrawAllView.m
//  HHDrawRectDemo
//
//  Created by LXH on 2017/6/26.
//  Copyright © 2017年 HHLM. All rights reserved.
//

#import "HHDrawAllView.h"

@implementation HHDrawAllView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *color = [UIColor redColor];
    
    [[UIColor redColor] set];
    
    UIFont *font = [UIFont systemFontOfSize:16];
    
    NSString *title1 = @"画圆:";
    
    [title1 drawInRect:CGRectMake(10, 90, 80, 20) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color,NSBackgroundColorAttributeName:[UIColor blueColor]}];
    CGContextStrokePath(context);
    
    //设置线条宽度
    CGContextSetLineWidth(context, 1.0);
    //线条颜色
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    
    /*--------------------------- 画圆 ---------------------------*/
    
    //第一个圆
    
    //画线
    CGContextAddArc(context, 100, 100, 25, 0, 2*M_PI, 0);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
    //第二个圆 填充
    
    //画曲线 25半径 逆时针
    CGContextAddArc(context, 170, 100, 25, 0, 2*M_PI, 0);
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    //CGContextFillPath(context); //填充颜色
    CGContextDrawPath(context, kCGPathEOFillStroke);

    
    //第三个圆
    CGContextAddEllipseInRect(context, CGRectMake(210, 78.5, 50, 50));
    CGContextAddRect(context, CGRectMake(210, 78.5, 50, 50));
    CGContextDrawPath(context, kCGPathStroke);
    
    //第四个圆 填充
    CGContextAddEllipseInRect(context, CGRectMake(270, 78.5, 50, 50));
    CGContextSetFillColorWithColor(context, [UIColor cyanColor].CGColor);
    CGContextFillPath(context);
    
    
    //第五个圆 渐变颜色
    CGColorSpaceRef  rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        1,1,1, 1.00,
        1,1,0, 1.00,
        1,0,0, 1.00,
        1,0,1, 1.00,
        0,1,1, 1.00,
        0,1,0, 1.00,
        0,0,1, 1.00,
        0,0,0, 1.00,};
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    CGColorSpaceRelease(rgb);
    
    //下面再看一个颜色渐变的圆
    CGContextDrawRadialGradient(context, gradient, CGPointMake(355, 100), 0.0, CGPointMake(355, 100), 25, kCGGradientDrawsBeforeStartLocation);
    


    
    
    /*--------------------------- 画矩形 ---------------------------*/
    
    
    NSString *string = @"画矩形:";
    
    [string drawInRect:CGRectMake(10, 170, 80, 20) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
    
    // 第一个矩形
    CGContextAddRect(context, CGRectMake(80, 160, 50, 50));
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    
    
    // 第二个矩形 虚线矩形
    CGFloat lengths[] = {5,5};
    CGContextSetLineDash(context, 0, lengths, 2); //虚线
    CGContextSetLineCap(context, kCGLineCapRound);//线的拐角
    CGContextSetStrokeColorWithColor(context, [UIColor purpleColor].CGColor);
    CGContextAddRect(context, CGRectMake(150, 160, 50, 50));
    CGContextDrawPath(context, kCGPathStroke);
    
    
    //第三种
    CGPoint points[] = {CGPointMake(220, 160),CGPointMake(220, 210),CGPointMake(270, 210),CGPointMake(270, 160)};
     CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextAddLines(context, points, 4);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    CGContextClosePath(context);
    
    
    //第四种
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextFillRect(context, CGRectMake(290, 160, 50, 50));
    CGContextDrawPath(context, kCGPathFill);
    
    /*------------------------- 画三角形 --------------------------*/
    
    NSString *string1 = @"画三角形和扇形:";
    
    [string1 drawInRect:CGRectMake(10, 250, 120, 20) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
    
    CGFloat lengths1[] = {5,0};
    CGContextSetLineWidth(context, 3);
    CGContextSetLineDash(context, 0, lengths1, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    
    //第一种
    CGContextMoveToPoint(context, 140, 260);
    CGContextAddLineToPoint(context, 170, 235);
    CGContextAddLineToPoint(context, 180, 280);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke);
    
    //第二种
    
    CGPoint point2[] = {CGPointMake(190, 260),CGPointMake(210, 235),CGPointMake(230, 290)};
    CGContextAddLines(context, point2, 3);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
    //扇形 -- 画圆，只不过是设置角度的大小，形成一个扇形
    CGContextMoveToPoint(context, 350, 280);
    CGContextAddArc(context, 350, 280,50, - M_PI/180 * 60, -120* M_PI/180 , 0); // 1 顺时针 0 逆时针
    CGContextClosePath(context); //封闭路线
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
    //扇形
    CGContextMoveToPoint(context, 270, 280);
    CGContextAddArc(context, 270, 280,50, - M_PI/180 * 60, -120* M_PI/180 , 1); // 1 顺时针 0 逆时针
    CGContextClosePath(context); //封闭路线
    CGContextDrawPath(context, kCGPathStroke);
    
    /*----------------------- 椭圆和圆角矩形 ------------------------*/

    NSString *string2 = @"椭圆和圆角矩形:";
    [string2 drawInRect:CGRectMake(10, 320, 120, 20) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
    
    CGContextSetLineWidth(context, 1.5);
    CGContextSetStrokeColorWithColor(context, [UIColor cyanColor].CGColor);
    
    //椭圆
    CGContextAddEllipseInRect(context, CGRectMake(135, 300, 70, 50));
    CGContextDrawPath(context, kCGPathStroke);
    
    CGFloat fw = 220;
    CGFloat fh = 300;
    //设置起点坐标
    CGContextMoveToPoint(context, fw, fh+10);
    
    //设置贝塞尔曲线的弧度的控制点坐标和弧度的终点坐标
    CGContextAddArcToPoint(context, fw, fh, fw+10, fh, 10);
    CGContextAddArcToPoint(context, fw+80, fh, fw+80, fh+10, 10);
    CGContextAddArcToPoint(context, fw+80, fh+60, fw+70, fh+60, 10);
    CGContextAddArcToPoint(context,fw, fh+60, fw, fh+50, 10);
    
    //封闭曲线
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
    /*--------------------------- 画曲线 --------------------------*/
    
    NSString *string3 = @"画曲线：";
    [string3 drawInRect:CGRectMake(10, 400, 80, 20) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
    
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    //二次曲线
    CGContextMoveToPoint(context, 120, 375);//设置Path的起点
    //设置贝塞尔曲线的控制点坐标和终点坐标
    CGContextAddQuadCurveToPoint(context,190, 410, 120, 490);
    CGContextDrawPath(context, kCGPathStroke);
    
    //三次曲线
    
    //设置起点
    CGContextMoveToPoint(context, 210, 375);
    
    //设置控制点 、控制点、 终点
    CGContextAddCurveToPoint(context, 240, 490, 280, 280, 350, 480);
    CGContextDrawPath(context, kCGPathStroke);
    
    /*--------------------------- 图片 ---------------------------*/
    
    NSString *string4 = @"图片:";
    [string4 drawInRect:CGRectMake(10, 520, 80, 20) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
    
    
    UIImage *image = [UIImage imageNamed:@"cplistwx"];
    [image  drawInRect:CGRectMake(100, 500, 50, 50)];
    
    //这样得到的图片是反的
    CGContextDrawImage(context, CGRectMake(100, 500, 50, 50), image.CGImage);
    
    //这样得到的图片是正的
    UIGraphicsPushContext(context);
    [image  drawInRect:CGRectMake(200, 500, 50, 50)];
    UIGraphicsPopContext();
    
    /*----------------------- 其他:渐变色 -------------------------*/
    
    NSString *string5 = @"其他:";
    
    [string5 drawInRect:CGRectMake(10, 630, 80, 20) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
    
    //线条
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextMoveToPoint(context, 85, 580);
    CGContextAddLineToPoint(context, 220, 600);
    CGContextDrawPath(context, kCGPathStroke);
    
    
    //加矩形 填充渐变颜色
    
    //第一种渐变颜色填充
    CGContextAddRect(context, CGRectMake(240, 560, 80, 60));
    CAGradientLayer *gradient1 = [CAGradientLayer layer];
    gradient1.frame = CGRectMake(240, 560, 80, 60);
    gradient1.colors = @[(id)[UIColor whiteColor].CGColor,
                        (id)[UIColor grayColor].CGColor,
                        (id)[UIColor blackColor].CGColor,
                        (id)[UIColor yellowColor].CGColor,
                        (id)[UIColor blueColor].CGColor,
                        (id)[UIColor redColor].CGColor,
                        (id)[UIColor greenColor].CGColor,
                        (id)[UIColor orangeColor].CGColor,
                        (id)[UIColor brownColor].CGColor];
    [self.layer insertSublayer:gradient1 atIndex:0];
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
    //第二种颜色渐变填充
    
    CGColorSpaceRef sref = CGColorSpaceCreateDeviceRGB();
    
    CGFloat refColors[] =
    {
        1,1,1,1.0,
        1,1,0,1.0,
        1,0,1,1.0,
        1,0,0,1.0,
        0,1,1,1.0,
        0,1,0,1.0,
        0,0,1,1.0,
        0,0,0,1.0
    };
    
    CGGradientRef gradientRef = CGGradientCreateWithColorComponents(sref, refColors, NULL, sizeof(refColors)/(sizeof(refColors[0])*4));
    
    
    CGColorSpaceRelease(sref);
    
    CGContextSaveGState(context);
    CGContextMoveToPoint(context, 80, 600);
    CGContextAddLineToPoint(context, 160, 600);
    CGContextAddLineToPoint(context, 160, 650);
    CGContextAddLineToPoint(context, 80, 650);
    
    //裁剪路径 要不然填充颜色就会溢出
    CGContextClip(context);
    
    //CGContextSaveGState与CGContextRestoreGState的作用
    /*
     CGContextSaveGState函数的作用是将当前图形状态推入堆栈。
     之后，您对图形状态所做的修改会影响随后的描画操作，但不影响存储在堆栈中的拷贝。在修改完成后，您可以通过CGContextRestoreGState函数把堆栈顶部的状态弹出，返回到之前的图形状态。这种推入和弹出的方式是回到之前图形状态的快速方法，避免逐个撤消所有的状态修改；这也是将某些状态（比如裁剪路径）恢复到原有设置的唯一方式。
     */
    
    
    // 开始坐标和结束坐标是控制渐变的方向和形状
    CGContextDrawLinearGradient(context, gradientRef, CGPointMake(80, 600), CGPointMake(160, 650), kCGGradientDrawsBeforeStartLocation);
    
    // 恢复到之前的context
    CGContextRestoreGState(context);
    
    
    //一个颜色渐变的圆
    CGContextDrawRadialGradient(context, gradient, CGPointMake(240, 670), 10, CGPointMake(240, 670), 40, kCGGradientDrawsBeforeStartLocation);
    
    
    
}

@end
