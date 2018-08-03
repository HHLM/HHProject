//
//  HHManager.h
//  HHWeChatFloatView
//
//  Created by Mac on 2018/8/3.
//  Copyright © 2018年 Now. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHFloatView.h"
#import <UIKit/UIKit.h>
#import "HHFloatAlertView.h"
@interface HHManager : NSObject

/** 浮窗VC */
@property (nonatomic, strong) UIViewController *floatViewController;

@property (nonatomic, strong) NSMutableArray *floatArray;
/** 浮窗 */
@property (nonatomic, strong) HHFloatView *floatView;
/** 浮窗提示view */
@property (nonatomic, strong) HHFloatAlertView *floatAlert;

/** 是否已经能展示了浮窗 */
@property (nonatomic, assign, getter=isShowFloat) BOOL showFloat;

@property (nonatomic, assign,) CGRect lastFrame;

/**
 弄个单利 避免在展示页面 滑动返回时候不能提示 展示浮窗
 */
+ (HHManager *)shareManager;

/** 展示浮窗 */
- (void)showFloatView;

/** 移除浮窗 */
- (void)dismissFloatView;
@end
