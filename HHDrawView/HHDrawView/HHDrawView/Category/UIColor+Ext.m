//
//  UIColor+Ext.m
//  HHDrawView
//
//  Created by Mac on 2018/6/8.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "UIColor+Ext.h"

@implementation UIColor (Ext)

+ (UIColor *)randomColor {
    
    CGFloat r = arc4random_uniform(255)/255.0;
    CGFloat g = arc4random_uniform(255)/255.0;
    CGFloat b = arc4random_uniform(255)/255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
    
}
@end
