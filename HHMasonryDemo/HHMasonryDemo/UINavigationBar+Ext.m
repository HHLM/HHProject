//
//  UINavigationBar+Ext.m
//  UIAlertViewController
//
//  Created by Mac on 2018/5/31.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "UINavigationBar+Ext.h"
#import <objc/runtime.h>


static NSString *const heightKey = @"heightKey";

@implementation UINavigationBar (Ext)

- (void)setNavBarHeight:(CGFloat)navBarHeight {
    objc_setAssociatedObject(self, &heightKey, @"navBarHeight", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)navBarHeight {
    return [objc_getAssociatedObject(self, &heightKey) floatValue];
}


- (CGSize)sizeThatFits:(CGSize)size {
    CGSize newSize;
    if (self.navBarHeight) {
        newSize = CGSizeMake(self.superview.bounds.size.width, self.navBarHeight);
    }else {
        newSize = [super sizeThatFits:size];
    }
    return newSize;
}


@end
