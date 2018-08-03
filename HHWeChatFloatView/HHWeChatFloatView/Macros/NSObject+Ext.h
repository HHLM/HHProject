//
//  NSObject+Ext.h
//  HHWeChatFloatView
//
//  Created by Mac on 2018/7/6.
//  Copyright © 2018年 Now. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (Ext)


- (UIWindow *)keyWindow;

- (UIViewController *)topViewController;

- (UIViewController *)currentViewConroller;

- (UITabBarController *)currentTabBarController;

- (UINavigationController *)currentNavigationController;

@end
