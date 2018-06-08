//
//  UIButton+Ext.h
//  HHDrawView
//
//  Created by Mac on 2018/6/9.
//  Copyright © 2018年 Now. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Ext)

+ (UIButton *)initWithTitle:(NSString *)title
                   fontSize:(CGFloat)fontSize
                  textColor:(UIColor *)textColor
                     target:(id)target
                    seletor:(SEL)selector;
@end
