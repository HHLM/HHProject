//
//  HHPaintView.h
//  HHDrawRectDemo
//
//  Created by LXH on 2017/6/26.
//  Copyright © 2017年 HHLM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHPaintView : UIView


@property (nonatomic, assign) CGFloat paintWidth;

@property (nonatomic, strong) UIColor *paintColor;

- (void)clear;

- (void)back;

@end
