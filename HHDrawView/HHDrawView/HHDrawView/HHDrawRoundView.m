//
//  HHDrawRoundView.m
//  HHDrawDemo
//
//  Created by Mac on 2018/6/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "HHDrawRoundView.h"

@implementation HHDrawRoundView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addRound6];
        
    }return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self addRound1];
    [self addRound2];
    [self addRound3];
    [self addRound4];
    [self addRound5];
    

}

- (void)addRound6 {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 200, 200) cornerRadius:100];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.lineWidth = 5;
    layer.fillColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1].CGColor;
    layer.strokeColor = [UIColor yellowColor].CGColor;
    [self.layer addSublayer:layer];
    
    /** 添加动画 */
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(400, 500)];
    /** 运动时间 */
    animation.duration = 1;
    /** 重复次数 */
    animation.repeatDuration = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [layer addAnimation:animation forKey:nil];
    
}
/** 画椭圆 */
- (void)addRound5 {
    /** 1.获取图形上下文 */
    CGContextRef ctx =UIGraphicsGetCurrentContext();
    /** 2.描绘路径 */
    UIBezierPath *path =[UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, self.height - 200, 200, 100)];
    
    /** 保存当前图形上下文状态 */
    CGContextSaveGState(ctx);
    
    [[UIColor brownColor] set];
    /** 平移 */
    CGContextTranslateCTM(ctx, 100, 10);
    /** 图形缩放 */
//    CGContextScaleCTM(ctx, 0.5, 0.5);
    /** 图形旋转 */
//    CGContextRotateCTM(ctx, M_PI_2);
    
    /** 3.添加到图形上下文 */
    CGContextAddPath(ctx, path.CGPath);
    /** 4.渲染图形上下文 填充整个区域 */
    CGContextFillPath(ctx);
    
    /** 恢复之前保存的图形上下文状态 */
    CGContextRestoreGState(ctx);
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, self.height - 200, 100, 80)];
    CGContextAddPath(ctx, path.CGPath);
    /** 描边 */
    CGContextStrokePath(ctx);
    
}
- (void)addRound1 {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 20, 200, 200) cornerRadius:100];
    [[UIColor greenColor] set];
    
//    [path stroke];
    
    [path fill];
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
