//
//  HHScrawlView.m
//  HHDrawView
//
//  Created by Mac on 2018/6/9.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHScrawlView.h"

/** 按钮的y坐标 */
static CGFloat const top = 10;
/** 画线的顶部边界 */
static CGFloat const topLimits = 60;

@interface HHScrawlView()
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *middleBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@end

@implementation HHScrawlView
{
    NSMutableArray *paths;
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton initWithTitle:@"清除" fontSize:17 textColor:[UIColor blueColor] target:self seletor:@selector(clear)];
        [_leftBtn setFrame:CGRectMake(10, top, 60, 40)];
    }
    return _leftBtn;
}

- (UIButton *)middleBtn {
    if (!_middleBtn) {
        _middleBtn = [UIButton initWithTitle:@"退后" fontSize:17 textColor:[UIColor blueColor] target:self seletor:@selector(back)];
        [_middleBtn setFrame:CGRectMake(CGRectGetWidth(self.frame)/2 -30, top, 60, 40)];
    }
    return _middleBtn;
}
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton initWithTitle:@"退后" fontSize:17 textColor:[UIColor blueColor] target:self seletor:@selector(save)];
        [_rightBtn setFrame:CGRectMake(CGRectGetWidth(self.frame)-70, top, 60, 40)];
    }
    return _rightBtn;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        paths  = [NSMutableArray array];
        [self addSubview:self.leftBtn];
        [self addSubview:self.middleBtn];
        [self addSubview:self.rightBtn];
    }
    return self;
}
/** 撤销上一步 */
- (void)back {
    [paths removeLastObject];
    [self setNeedsDisplay];
}
/** 清除所有画线 */
- (void)clear {
    [paths removeAllObjects];
    [self setNeedsDisplay];
}
/** 截图 */
- (void)save {
    
}

/** 添加一条横线 */
- (void)addTopLimits {
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    linePath.lineWidth = 1;
    [[UIColor greenColor] set];
    [linePath moveToPoint:CGPointMake(0, topLimits)];
    [linePath addLineToPoint:CGPointMake(self.width, topLimits)];
    [linePath stroke];
}

- (void)drawRect:(CGRect)rect {
    
    [self addTopLimits];
    
    //遍历所有的路径
    for (UIBezierPath *path in paths) {
        /** 设置颜色 */
        [[UIColor redColor] set];
        /** 线条宽度 */
        path.lineWidth = 3;
        /** 线条订端的样式 */
        path.lineCapStyle = kCGLineCapRound;
        /** 线条交叉样式 */
        path.lineJoinStyle = kCGLineJoinRound;
        /** 渲染 */
        [path stroke];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //获取起点
    CGPoint point = [[touches anyObject] locationInView:self];
    //不在范围内不处理
    if (point.y < topLimits) return;
    /** 创建一个贝塞尔 */
    UIBezierPath *path = [UIBezierPath bezierPath];
    /** 起点 */
    [path moveToPoint:point];
    /** 把当前的路径加到数组中 */
    [paths addObject:path];
    /** 重新绘制 */
    [self setNeedsDisplay];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /** 获取移动到的点 */
    CGPoint point = [[touches anyObject] locationInView:self];
    /** 范围控制 */
    if (point.y < topLimits) return;
    /** 获取到最后一个路径 以便于连线 */
    UIBezierPath *path = [paths lastObject];
    /** 画线 */
    [path addLineToPoint:point];
    /** 重新绘制 */
    [self setNeedsDisplay];
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchesMoved:touches withEvent:event];
}

@end
