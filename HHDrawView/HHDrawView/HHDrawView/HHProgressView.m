//
//  HHProgressView.m
//  HHDrawView
//
//  Created by Mac on 2018/6/8.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHProgressView.h"

@implementation HHProgressView
{
    CGFloat addAngle;   //增加开始角度
    CGFloat starAngle;  //开始角度
    CGFloat endAngle;   //结束角度
    CGFloat radius ;    //半径
    NSString *textString;
    CADisplayLink *link;
    NSArray *dataArray;
    BOOL isShow;
}

- (void)star {
    starAngle = -M_PI_2;
    endAngle = starAngle;
    radius = 150;
    link = [CADisplayLink displayLinkWithTarget:self selector:@selector(aaaa)];
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    dataArray = @[@30,@45,@25];
    
    
    
}

- (void)drawRect:(CGRect)rect {
    [self addProgress1];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:24];
    attributes[NSForegroundColorAttributeName] = [UIColor redColor];
    [textString drawInRect:CGRectMake(160, 180, 200, 40) withAttributes:attributes];
    if (isShow) {
        [self addRoundView];
    }
    
}

- (void)addRoundView {
    
    CGPoint center = CGPointMake(200, 500);
    CGFloat starA = 0;
    CGFloat endA = 0;
    
    /** 每个扇形所占比例  第一个扇形结束时候的角度是下一个扇形的开始角度  */
    
    for (NSNumber *number in dataArray) {
       
        //计算每个扇形占比 的角度
        CGFloat addA = [number floatValue]/100 * M_PI*2;
        /** 计算结束角度 */
        endA = starA + addA;
        /** 描绘路径 */
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:100
                                                        startAngle:starA
                                                          endAngle:endA
                                                         clockwise:YES];
        /** 和中心点连线 */
        [path addLineToPoint:center];
        /** 设置颜色 */
        [[UIColor randomColor] set];
        /** 填充颜色 会会默认封闭空间 */
        [path fill];
        /** 下一个扇形的起始角度 是当前扇形的结束角度 */
        starA = endA;
        
    }
}

- (void)addProgress1 {
    CGPoint center = CGPointMake(200, 200);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:starAngle endAngle:endAngle clockwise:YES];
    path.lineWidth = 3;
    [[UIColor redColor] set];
    [path stroke];
}

- (void)aaaa {
    addAngle = M_PI * 2 / 360;
    if (endAngle > M_PI * 2 - M_PI_2) {
        starAngle = starAngle + addAngle;
        endAngle = M_PI * 2 - M_PI_2;
        [link invalidate];
        isShow = YES;
    }
    if (starAngle >= M_PI * 2 - M_PI_2 ) {
        starAngle = -M_PI_2;
        endAngle = starAngle +addAngle;
    }
   
    endAngle = endAngle + addAngle;
    textString = [NSString stringWithFormat:@"%0.2f%%",(endAngle - starAngle)/M_PI/2*100];
    if ([textString isEqualToString:@"100.00%"]) {
        textString = @"下载完成";
    }
    NSLog(@"%f",endAngle);
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self star];
}

@end
