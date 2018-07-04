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

@implementation HHAnimationView1

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor redColor];
        
        /** 创建一个复制层layer 这样就可以复制多个相同的layer */
        CAReplicatorLayer *rLayer = [CAReplicatorLayer layer];
        
        rLayer.frame = self.bounds;
        
        [self.layer addSublayer:rLayer];
        
        /** 创建一个layer */
        CALayer *layer = [CALayer layer];
        
        CGFloat w = 30;
        
        CGFloat H = 200;
        
        /** 设置当前位置在 也就是相当于中心位置 */
        layer.position = CGPointMake(w, CGRectGetHeight(self.frame));
        
        layer.backgroundColor = [UIColor greenColor].CGColor;
        
        /** 锚点 默认(0.5,0.5)  就相当于是中心点*/
        layer.anchorPoint = CGPointMake(0.5, 1);
        
        layer.bounds = CGRectMake(0, 0, w, H);
        
        /** 创建一个基本动画 */
        CABasicAnimation *anim = [CABasicAnimation animation];
        
        /** 这是用的kvo的思想 这个动画代表缩放 */
        anim.keyPath = @"transform.scale.y";
        
        anim.fromValue = @1;
        
        anim.toValue = @0.3;
        
        anim.autoreverses = YES;
        
        /** 动画重复次数  无穷*/
        anim.repeatCount = MAXFLOAT;
        
        /** 动画持续时间  */
        CGFloat duration = 0.2f;
        
        anim.duration = duration;
        
        /** 把动画添加到layer上 */
        [layer addAnimation:anim forKey:nil];
        
        /** 把layer添加到复制层上 */
        [rLayer addSublayer:layer];
        
        /** 要复制多少个layer */
        NSInteger count = 5;
        
        rLayer.instanceCount = count;
        
        rLayer.instanceTransform = CATransform3DMakeTranslation(2*w, 0, 0);;
        
        rLayer.instanceDelay = 0.1;
    }
    return self;
}

@end
