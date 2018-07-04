//
//  UIControl+Ext.h
//  HHRuntime
//
//  Created by Mac on 2018/5/25.
//  Copyright © 2018年 Now. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (Ext)

/** 点击间隔时间 */
@property (nonatomic, assign) NSTimeInterval eventInterval;

/** 能否被点击 */
@property (nonatomic, assign) BOOL ignoreEvent;

@end
