//
//  HHClipRoundView.m
//  HHDrawRectDemo
//
//  Created by LXH on 2017/6/28.
//  Copyright © 2017年 HHLM. All rights reserved.
//

#import "HHClipRoundView.h"

@implementation HHClipRoundView


- (void)drawRect:(CGRect)rect {
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0.0 alpha:0.5].CGColor);
    
    CGContextFillRect(context, self.frame);
    
    CGFloat radius = self.frame.size.width/2;
    
    CGContextAddArc(context, self.center.x, self.center.y, radius, 0, 2*M_PI, 0);
    CGContextClip(context);
    CGContextClearRect(context, CGRectMake(self.center.x - radius, self.center.y - radius, 2 *radius, 2 *radius));
    
//    CGContextStrokePath(context);
    CGContextDrawPath(context, kCGPathStroke);
    
    
    
}


@end
