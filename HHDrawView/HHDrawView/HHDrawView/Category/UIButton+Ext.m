//
//  UIButton+Ext.m
//  HHDrawView
//
//  Created by Mac on 2018/6/9.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "UIButton+Ext.h"

@implementation UIButton (Ext)

+ (UIButton *)initWithTitle:(NSString *)title
                   fontSize:(CGFloat)fontSize
                  textColor:(UIColor *)textColor
                     target:(id)target
                    seletor:(SEL)selector {
    
    UIButton*button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    if (fontSize) {
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }else {
        button.titleLabel.font = [UIFont systemFontOfSize:18];
    }
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}
@end
