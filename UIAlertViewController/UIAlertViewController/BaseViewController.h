//
//  BaseViewController.h
//  UIAlertViewController
//
//  Created by Mac on 2018/5/30.
//  Copyright © 2018年 Now. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  HNavBarHeight  (([[UIApplication sharedApplication] statusBarFrame].size.height > 20) ? 88 : 64)
#define HStatueBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

@interface BaseViewController : UIViewController

/** 导航 */
@property (nonatomic, strong) UIView *navBarView;

/** 透明页面导航颜色  默认白色*/
@property (nonatomic, strong) UIColor *navBarColor;

/** 导航透明度 默认为0  */
@property (nonatomic, assign) CGFloat navBarAlpha;

/** 标题 */
@property (nonatomic, copy) NSString *titleStr;

/** 导航是否透明 */
@property (nonatomic, assign, getter=isTransparence) BOOL transparence;
@end
