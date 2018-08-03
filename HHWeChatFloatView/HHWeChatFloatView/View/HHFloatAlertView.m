//
//  HHFloatAlertView.m
//  HHWeChatFloatView
//
//  Created by Mac on 2018/7/5.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHFloatAlertView.h"
#import "HHFiles.h"
@interface HHFloatAlertView()
@property (nonatomic, strong) UIImageView *roundView;
@property (nonatomic, strong) CAShapeLayer  *roundLayer;
@property (nonatomic, strong) CATextLayer *textLayer;
@property (nonatomic, assign) CGFloat radius;
@end

@implementation HHFloatAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer addSublayer:self.roundLayer];
        [self.layer addSublayer:self.roundView.layer];
        [self.layer addSublayer:self.textLayer];
        self.heightLight = YES;
    }
    return self;
}

- (CAShapeLayer *)roundLayer {
    if (!_roundLayer) {
        _roundLayer = [CAShapeLayer layer];
        /** 画一个圆的 右上部分 */
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width, self.width) radius:self.width startAngle:M_PI endAngle:M_PI*3/2 clockwise:YES];
        /** 连线 */
        [path addLineToPoint:CGPointMake(self.width, self.width)];
        /** 封闭 */
        [path closePath];
        
        _roundLayer.path = path.CGPath;
        
        _roundLayer.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.4].CGColor;
    }return _roundLayer;
}
- (UIImageView *)roundView {
    if (!_roundView) {
        _roundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _roundView.center = CGPointMake(self.width/2, self.width/2);
        _roundView.layer.contents = (__bridge id  _Nullable)[UIImage imageNamed:@"round_remove"].CGImage;
    }return _roundView;
}

- (CATextLayer *)textLayer {
    if (!_textLayer) {
        _textLayer = [CATextLayer layer];
        _textLayer.string = @"添加浮窗";
        _textLayer.alignmentMode = kCAAlignmentCenter;
        _textLayer.frame = CGRectMake(0, self.width/2 + 40, self.width, 20);
        _textLayer.fontSize  = 14;
    }return _textLayer;
}

- (void)setHeightLight:(BOOL)heightLight {
    _heightLight = heightLight;
    if (_heightLight) {
        self.roundLayer.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.8].CGColor;
        self.roundView.image = [UIImage imageNamed:@"round_remove"];
        self.textLayer.string = @"移除浮窗";
    }else {
        self.roundLayer.fillColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8].CGColor;
        self.roundView.image = [UIImage imageNamed:@"round_remove"];
        self.textLayer.string = @"添加浮窗";
    }
    
}

@end
