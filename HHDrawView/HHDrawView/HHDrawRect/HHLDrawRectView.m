//
//  HHLDrawRectView.m
//  HHDrawRectDemo
//
//  Created by LXH on 2017/6/23.
//  Copyright © 2017年 HHLM. All rights reserved.
//

#import "HHLDrawRectView.h"

@implementation HHLDrawRectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
//        [self drawRect:frame];
    }
    return self;
}

- (void)setDrawType:(HHDrawType)drawType {
    _drawType = drawType;
}
- (void)drawRect:(CGRect)rect {
    switch (_drawType) {
        case HHDrawTextType:
            [self drawMyText];
            break;
        case HHDrawLineType:
            [self drawLine];
            break;
        case HHDrawSquareType:
            [self drawSquareness];
            [self drawSquarene];
            break;
        case HHDrawRoundType:
            [self drawRound];
            break;
        case HHDrawDashLinType:
            [self drawDashLine];
            break;
        case HHDrawImageType:
            [self drawImage];
            break;
        default:
            break;
    }

}

- (void)drawDashLine {
    //设置画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线条颜色
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    //设置线条宽度
    CGContextSetLineWidth(context, 1.f);
    
    //设置曲线
    CGFloat lengths[] = {5,5};
    CGContextSetLineDash(context, 4, lengths, 2);
    
    //线条起点
    CGContextMoveToPoint(context, 10,350);
    //终点
    CGContextAddLineToPoint(context,self.frame.size.width - 20, 350);
    //开始画线
    CGContextStrokePath(context);
    
      CGContextClosePath(context);
    
    CGPoint points[] = {CGPointMake(50, 100),CGPointMake(50, 300),CGPointMake(150, 300),CGPointMake(150, 100),CGPointMake(50, 100),CGPointMake(50, 200),CGPointMake(150, 200)};
    CGContextAddLines(context, points, 7);
    CGContextStrokePath(context);
    CGContextClosePath(context);
    
    CGPoint points1[] = {CGPointMake(300, 100),CGPointMake(200, 100),CGPointMake(200, 200),CGPointMake(300, 200),CGPointMake(300, 300),CGPointMake(200, 300)};
    CGContextAddLines(context, points1, 6);
    
    CGContextStrokePath(context);
    
    //封闭当前线路
    CGContextClosePath(context);
}

- (void)drawLine {
    CGContextRef context = UIGraphicsGetCurrentContext(); //获取画布
    //线条颜色
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    
//     CGContextSetRGBStrokeColor(context, 0.5, 0.3, 0.5, 1.0f);
    
    //设置线条平滑，不需要两边的像素
    CGContextSetShouldAntialias(context, NO);
    
    
    //设置线条宽度
    CGContextSetLineWidth(context, 1.0f);
    
    //设置线条的起点
    CGContextMoveToPoint(context, 10, 80);
    
//    //设置线条结束点
    CGContextAddLineToPoint(context, self.frame.size.width - 10, 100);
    
    CGContextAddQuadCurveToPoint(context, 10, 500, 300, 200);
//
//    //结束，开始画
    CGContextStrokePath(context);
//
    CGContextClosePath(context);
    
    
    CGContextMoveToPoint(context, 100, 100);
    CGContextAddArcToPoint(context, 10, 500, 300, 400, 100);
    CGContextStrokePath(context);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0, self.frame.size.height);
}
//绘制文本
- (void)drawMyText {
    UIColor *color = [UIColor redColor];
    // 图形剩下文中设置颜色
    [color set];
    // 加载字体
    UIFont *font = [UIFont systemFontOfSize:24];
    // 绘制的字符串
    NSString *string = @"天下无双，登堂入室~";
    [string drawInRect:CGRectMake(10, 100, 300, 60) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
}
// 画圆
- (void)drawRound {
    CGContextRef context = UIGraphicsGetCurrentContext(); //获取画布
    //t填充颜色
    CGContextSetLineWidth(context, 10);
    CGContextSetStrokeColorWithColor(context, [UIColor purpleColor].CGColor);
    CGContextAddArc(context, 200, 200, 100, 0, 2*M_PI, 1);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillPath(context);
    CGContextStrokePath(context);
    CGContextClosePath(context);
    
    CGContextAddEllipseInRect(context, CGRectMake(100, 350, 200, 200));
    CGContextStrokePath(context);
    
}
// 无边框矩形
- (void)drawSquareness {
    
    CGContextRef context = UIGraphicsGetCurrentContext(); //获取画布
    
    
    //渐变颜色
    CGContextClip(context);
    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    
    CGFloat colors[] =
    {
        204.0 / 255.0, 224.0 / 255.0, 244.0 / 255.0, 1.00,
        29.0 / 255.0, 156.0 / 255.0, 215.0 / 255.0, 1.00,
        0.0 / 255.0,  50.0 / 255.0, 126.0 / 255.0, 1.00,
    };
    
    
    
    /**
     绘制背景渐变色

     space: 色彩空间 color Space 类型是CGColorSpaceRef GRB的色彩空间
     components: 颜色分量数组 CGFloat类型的红、绿、蓝和alpha值 #>
     locations: 位置数组 颜色的位置 控制颜色渐变的速度 >
     count: 位置的数量  指明需要多少颜色和位置
     */
    CGGradientRef gradient = CGGradientCreateWithColorComponents
    (rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    
    CGColorSpaceRelease(rgb);
    
    //KCGGradientDrawsAfterEndLocation扩展整个渐变到渐变的终点之后的所有点
    //KCGGradientDrawsBeforeStartLocation扩展整个渐变到渐变的起点之前的所有点。0不扩展该渐变。
    CGContextDrawLinearGradient(context, gradient,CGPointMake
                                (0.0,0.0) ,CGPointMake(self.frame.size.width,self.frame.size.height),
                                kCGGradientDrawsAfterEndLocation);
    CGContextClosePath(context);
    
    //t填充颜色
    CGContextSetRGBFillColor(context, 1.0, 0, 0.5, 1.0);
    
    //矩形大小
    CGContextFillRect(context, CGRectMake(200, 200, 100, 100));
    
    CGContextStrokePath(context);
    
    
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, self.frame.size.width, self.frame.size.height, 8, 4 * self.frame.size.width, CGColorSpaceCreateDeviceRGB(), kCGImageAlphaNoneSkipFirst);
    
    CGImageRef cgImage = CGBitmapContextCreateImage(bitmapContext);
    
    // Create a UIImage from CGImage
    
    UIImage *uiImage = [UIImage imageWithCGImage:cgImage];
    
    // Release the CGImage
    
    CGImageRelease(cgImage);
    
    // Release the bitmap context
    
    CGContextRelease(bitmapContext);
    
    // Create the patterned UIColor and set as background color
    
    [self setBackgroundColor:[UIColor colorWithPatternImage:uiImage]];
    
}

// 有边框矩形
- (void)drawSquarene {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //填充颜色
    CGContextSetRGBFillColor(context, 0.3, 0.5, 1, 1.f);
    
    //大小
    CGContextFillRect(context, CGRectMake(50, 200, 100, 100));
    
    //设置边框颜色
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1.0f);
    
    //线条宽度
    CGContextSetLineWidth(context, 2);
    
    //话椭圆
    CGContextAddEllipseInRect(context, CGRectMake(200, 350, 100, 200));
    // 设置线条终点形状
    CGContextSetLineCap(context, kCGLineCapRound);
    
    //开始画矩形框
    CGContextAddRect(context, CGRectMake(50, 200, 100, 100));
    
    //开始描点
    CGContextStrokePath(context);
    
//    CGContextClosePath(context);
    
    CGPoint points[] = {CGPointMake(100, 400),CGPointMake(180, 500),CGPointMake(260, 400),CGPointMake(180, 300),CGPointMake(100, 400)};
    
    CGContextAddLines(context, points, 5);
    CGContextStrokePath(context);
    

}
- (void)drawImage {
    
    //获取画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 这样绘制的图片是上下翻转的
//    CGContextDrawImage(context, CGRectMake(50, 350, 300, 300), [UIImage imageNamed:@"cplistwx"].CGImage);
    
    
    UIGraphicsPushContext(context);
    [[UIImage imageNamed:@"cplistwx"] drawInRect:CGRectMake(50, 350, 50, 50)];
    UIGraphicsPopContext();
}

//划线的用法
- (void)drawInfo {
    
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    //画虚线
    
    CGFloat lengths[] = {10,10};
    
    /** CGContextSetLineDash(CGContextRef cg_nullable c, CGFloat phase,
     const CGFloat * __nullable lengths, size_t count)
     phase - 先绘制的长度
     lengths – 指明虚线是如何交替绘制，
     count – lengths数组的长度
     *
     * lengths的值｛10,10｝表示先绘制10个点，再跳过10个点，如此反复
     如果是 @{10，5，20}， 则意思变成 先绘制10个点， 再跳过5个点，再绘制20个点， 在跳过10个点，再绘制5个点，以此类推。
     
    若 phase == 2 就绘制的长度是 10 - 2 = 8 再跳过50 如此反复绘制
     */
    
    
    
    CGContextSetLineDash(context, 8, lengths, 2);
    
    //画线的起点
    CGContextMoveToPoint(context, 0, 80);
    
    //画直线 终点是（400，400）
    CGContextAddLineToPoint(context, 320, 600);
    
    //封闭当前绘制路线
    CGContextClosePath(context);
    
    [[UIColor redColor] set];
    
    
    //线条终点形状 枚举：
    /** CGLineCap
     kCGLineCapButt,
     kCGLineCapRound,
     kCGLineCapSquare
     */
    CGContextSetLineCap(context, kCGLineCapSquare);
    
    //设置线条宽度
    CGContextSetLineWidth(context, 1);
    
    //设置画笔颜色 RGB 和 颜色名字、元素颜色 三种方式
#if 0
    CGContextSetRGBStrokeColor(context, 0.4, 0.5, 0.5, 1);
#else
    CGContextSetStrokeColorWithColor(context, [UIColor cyanColor].CGColor);
#endif
    
    //第三种设置画笔颜色的方法
    CGFloat components[] = {0.0,0.0,1.0,1.0};//颜色元素
    
    CGContextSetStrokeColor(context, components);
    
    //封闭当前绘制路线
    CGContextClosePath(context);
    
    
    
    
    //画多条线
    CGPoint points[] = {CGPointMake(100, 200), CGPointMake(150,300),CGPointMake(200,200),CGPointMake(150,100),CGPointMake(100,200)};
    CGContextAddLines(context, points,5);
//    CGContextDrawPath(context, kCGPathStroke);
    //封闭当前绘制路线
    CGContextClosePath(context);
    
    
    
    
    //绘制多个矩形
    CGRect rect[] = {CGRectMake(100, 100, 40, 40),CGRectMake(200, 100, 40, 40)};
    
    CGContextAddRects(context, rect, 2);

    //封闭当前绘制路线
    CGContextClosePath(context);
    
    
    
    //画一些直线
//    CGContextStrokeLineSegments(context, points, 5);
//     CGContextDrawPath(context, kCGPathStroke);
    
    
    
    /**
     画圆弧曲线

     @param c#> context context#>
     @param x#> 起始点 x #>
     @param y#> 起始点 y description#>
     @param radius#> 圆弧直径直径大小 description#>
     @param startAngle#> 开始弧度 description#>
     @param endAngle#> 结束弧度 description#>
     @param clockwise#> 0 顺时针 1 逆时针 description#>
     @return
     */
    CGContextAddArc(context, 100, 550, 50, 0, M_PI, 0);
    CGContextClosePath(context);
    
    
    
    //画曲线 从点（50，400） --> (300,550) 直径是40的曲线
    CGContextAddArcToPoint(context, 50, 400, 300, 550, 100);
    CGContextClosePath(context);
    
    
    //绘制曲线
    CGContextAddQuadCurveToPoint(context, 10, 500, 400, 100);
    CGContextClosePath(context);
    
    //设置阴影颜色
    CGContextSetShadowWithColor(context, CGSizeMake(1, 2), 100, [UIColor greenColor].CGColor);
    
    //设置阴影
    CGContextSetShadow(context, CGSizeMake(1, 2), 100);
    CGContextClosePath(context);
    
    //画椭圆
    CGContextAddEllipseInRect(context, CGRectMake(100, 400, 100, 100));
     CGContextClosePath(context);
    
    
    //填充颜色
    CGContextSetFillColorWithColor(context, [UIColor purpleColor].CGColor);
    
    //假如是重叠路径 ，决定一个点是否被填充，有两种规则：
    /*
     1、 nonzero:非零绕数规则，加入一个点从左到右跨过，计数器+1，重右到左跨过，计数器-1 ；最后如果结果是0 者不填充，非零就填充
     2、even-odd :奇偶规则，既然如一个点被跨过，那么+1，最后是基数就被填充，偶数就不被填充。和方向不无关
     */
    
    
    //设置透明度
    CGContextSetAlpha(context, 0.5);
    
    //填充颜色的范围
//    CGContextFillRect(context, CGRectMake(200, 300, 200, 200));
    
    //画矩形
    CGContextAddRect(context, CGRectMake(100, 400, 100, 100));
    
    //改变画布的位置
    CGContextTranslateCTM(context, 0, self.frame.size.height);
    
    //反转画布
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //设置内置颜色质量等级
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    
    //从原图中取小图
    CGImageCreateWithImageInRect([UIImage imageNamed:@""].CGImage, CGRectMake(100, 100, 100, 100));
    
    

    CGContextStrokePath(context);
    
    
}


/*---------------------------  ---------------------------*/

/**
 CGContextRef context = UIGraphicsGetCurrentContext(); 设置上下文
 
 CGContextMoveToPoint           开始画线
 
 CGContextAddLineToPoint        画直线
 
 CGContextAddEllipseInRect      画一椭圆
 
 CGContextSetLineCap            设置线条终点形状
 
 CGContextSetLineDash           画虚线
 
 CGContextAddRect               画一方框
 
 CGContextStrokeRect            指定矩形
 
 CGContextStrokeRectWithWidth   指定矩形线宽度
 
 CGContextStrokeLineSegments    画一些直线
 
 CGContextAddArc                画已曲线
                                前俩店为中心 
                                中间俩店为起始弧度 
                                最后一数据 0是顺时针 1则逆时针
 
 //先画俩条线从point 到 弟1点， 从弟1点到弟2点的线 切割里面的圆
 CGContextAddArcToPoint(context,0,0, 2, 9, 40); 
 
 CGContextSetShadowWithColor    设置阴影
 
 CGContextSetRGBFillColor       这只填充颜色
 
 CGContextSetRGBStrokeColor     画笔颜色设置
 
 CGContextSetFillColorSpace     颜色空间填充
 
 CGConextSetStrokeColorSpace    颜色空间画笔设置
 
 CGContextFillRect              补充当前填充颜色的rect
 
 CGContextSetAlaha              透明度
 
 CGContextTranslateCTM          改变画布位置
 
 CGContextSetLineWidth          设置线的宽度
 
 CGContextAddRects              画多个线
 
 CGContextAddQuadCurveToPoint   画曲线
 
 CGContextStrokePath            开始绘制图片
 
 CGContextDrawPath              设置绘制模式
 
 CGContextClosePath             封闭当前线路
 
 
 先用CGContextStrokePath来描线,即形状
 后用CGContextFillPath来填充形状内的颜色.
 
 
 CGContextTranslateCTM(context, 0,rect.size.height);
 
 CGContextScaleCTM(context, 1.0, -1.0); 反转画布
 
 CGContextSetInterpolationQuality       背景内置颜色质量等级
 
 CGImageCreateWithImageInRect           从原图片中取小图
 
 字符串的写入可用 NSString本身的画图方法
 – (CGSize)drawInRect:(CGRect)rect withFont:(UIFont*)font lineBreakMode:(UILineBreakMode)lineBreakMode alignment:(UITextAlignment)alignment;    来写进去即可
 
 对图片放大缩小的功能就是慢了点
 
 UIGraphicsBeginImageContext(newSize);
 
 UIImage newImage = UIGraphicsGetImageFromCurrentImageContext();
 
 UIGraphicsEndImageContext();
 
 CGColorGetComponents（） 返回颜色的各个直 以及透明度 可用只读c*t float 来接收是个数组
 */

@end
