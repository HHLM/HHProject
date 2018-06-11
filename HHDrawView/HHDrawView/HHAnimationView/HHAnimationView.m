//
//  HHAnimationView.m
//  HHDrawView
//
//  Created by Mac on 2018/6/11.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHAnimationView.h"

@implementation HHAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addRoundActiviety];
    }
    return self;
}

- (void)addRoundActiviety {
    
    self.backgroundColor = [UIColor cyanColor];
    
    /** 创建复制layer */
    CAReplicatorLayer *rLayer = [CAReplicatorLayer layer];
    
    rLayer.frame = self.bounds;
    
    [self.layer addSublayer:rLayer];
    
    /** 创建layer */
    
    CALayer *layer = [CALayer layer];
    
    layer.position = CGPointMake(self.width/2, 20);
    
    layer.bounds = CGRectMake(0, 0, 10, 10);
    
    layer.cornerRadius = 5;
    
    layer.masksToBounds = YES;
    
    layer.backgroundColor = [UIColor purpleColor].CGColor;
    
    /** 把layer添加到复制图层上 */
    [rLayer addSublayer:layer];
    
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    
    anim.keyPath = @"transform.scale";
    
    anim.fromValue = @1.5;
    
    anim.toValue  = @.2;
    
    anim.repeatCount = MAXFLOAT;
    
    CGFloat duration = 0.5f;
    
    anim.duration = duration;
    
    [layer addAnimation:anim forKey:nil];
    
    NSInteger count = 20;
    
    /** 复制图层上展示多少个layer */
    rLayer.instanceCount = count;
    
    CGFloat angle = M_PI * 2 /count;
    /** 每个layer偏转多少 */
    rLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    /** 每个layer延时多久执行 */
    rLayer.instanceDelay = duration/count;
}

@end
