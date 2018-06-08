//
//  UIView+Ext.m
//  HHDrawView
//
//  Created by Mac on 2018/6/8.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "UIView+Ext.h"

@implementation UIView (Ext)

- (CGFloat)x {
    return CGRectGetMinX(self.frame);
}
- (void)setX:(CGFloat)x {
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (CGFloat)y {
    return CGRectGetMinY(self.frame);
}
- (void)setY:(CGFloat)y {
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (CGFloat)width {
    return CGRectGetWidth(self.frame);
}

- (void)setWidth:(CGFloat)width {
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}
- (void)setHeight:(CGFloat)height {
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}


@end
