//
//  UIView+Ext.m
//  HHDrawView
//
//  Created by Mac on 2018/6/8.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "UIView+Ext.h"

@implementation UIView (Ext)

- (CGFloat)width {
    return CGRectGetWidth(self.frame);
}
- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}
- (void)setHeight:(CGFloat)height {
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}
- (void)setWidth:(CGFloat)width {
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

@end
