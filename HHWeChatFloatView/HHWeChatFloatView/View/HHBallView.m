//
//  HHBallView.m
//  HHWeChatFloatView
//
//  Created by Mac on 2018/8/3.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHBallView.h"

@interface HHBallView()<CAAnimationDelegate> {
    
    CGRect fromRect;
    CGRect toRect;
    UIView *toView;
    
}
@end
@implementation HHBallView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    _imgView = [[UIImageView alloc] initWithFrame:frame];
    [self addSubview:_imgView];
    
    self.backgroundColor = [UIColor clearColor];
    
    return self;
    
}

- (void)startAnimationForView:(UIView *)view fromRect:(CGRect)fromRect toRect:(CGRect)toRect {
    
    toView = view;
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:fromRect cornerRadius:toRect.size.width/2.0].CGPath;
    _shapeLayer.fillColor = [UIColor grayColor].CGColor;
    self.imgView.layer.mask = _shapeLayer;
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.toValue = (__bridge id)[UIBezierPath bezierPathWithRoundedRect:toRect cornerRadius:toRect.size.width/2.0].CGPath;
    anim.duration = 0.25f;
    anim.delegate = self;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    
    [self.shapeLayer addAnimation:anim forKey:@"revealAnimation"];
    
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    
    toView.hidden = NO;
    [self removeFromSuperview];
    
}
@end

