//
//  HHPaintView.m
//  HHDrawRectDemo
//
//  Created by LXH on 2017/6/26.
//  Copyright © 2017年 HHLM. All rights reserved.
//

#import "HHPaintView.h"

#define KDefaultWidth  10

#define KDefaultColor [UIColor blackColor]

@interface HHPaintView ()


@property (nonatomic, strong) NSMutableArray *paints;
@end

@implementation HHPaintView


- (void)back {
    [self.paints removeLastObject];
    [self setNeedsDisplay];
}
- (void)clear {
    [self.paints removeAllObjects];
    [self setNeedsDisplay];
}
- (NSMutableArray *)paints {
    if (!_paints) {
        _paints = [NSMutableArray array];
    }return _paints;
}

- (void)setPaintWidth:(CGFloat)paintWidth {
    _paintWidth = paintWidth;
}
- (void)setPaintColor:(UIColor *)paintColor {
    _paintColor = paintColor;
}

- (void)drawRect:(CGRect)rect {
    
    //设置颜色
    [_paintColor set];
    
    for (UIBezierPath *path in self.paints)  {
        path.lineWidth = _paintWidth;
        
        [path stroke];//根据坐标连线
        
//        [path fill]; //填充
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _paintWidth = KDefaultWidth;
        
        _paintColor = KDefaultColor;
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    CGPoint starPoint = [touch locationInView:self];
    
    //创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    //设置线条类型
    path.lineCapStyle = kCGLineCapRound; //拐点
    
    path.lineJoinStyle = kCGLineJoinMiter;//终点处理

    path.miterLimit = 5;
    
    //设置起点
    [path moveToPoint:starPoint];
    
    [self.paints addObject:path];
    
    //开始展示
    [self setNeedsDisplay];
    
}
//连线
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    UIBezierPath *path = [self.paints  lastObject];
    //添加线条
    [path addLineToPoint:point];
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self touchesMoved:touches withEvent:event];
}
@end
