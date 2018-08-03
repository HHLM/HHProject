//
//  NSObject+Ext.m
//  HHWeChatFloatView
//
//  Created by Mac on 2018/7/6.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "NSObject+Ext.h"

@implementation NSObject (Ext)

- (UIWindow *)keyWindow {
    return [UIApplication sharedApplication].keyWindow;
}

- (UIViewController *)topViewController
{
    UIViewController *resultVC;
    
    resultVC = [self selectViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    
    while (resultVC.presentedViewController)
    {
        resultVC = [self selectViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)selectViewController:(UIViewController *)vc
{
    if ([vc isKindOfClass:[UINavigationController class]])
    {
        return [self selectViewController:[(UINavigationController *)vc topViewController]];
    }
    else if ([vc isKindOfClass:[UITabBarController class]])
    {
        return [self selectViewController:[(UITabBarController *)vc selectedViewController]];
    }
    else
    {
        return vc;
    }
    return nil;
}

- (UIViewController *)currentViewConroller {
    
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
   
    while (1)
    {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController *)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController *)vc).visibleViewController;
        }
        
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else {
            break;
        }
    }
    return vc;
}
- (UITabBarController *)currentTabBarController
{
    UIViewController  *vc = [UIApplication sharedApplication].keyWindow.rootViewController;

    if ([vc isKindOfClass:[UITabBarController class]])
    {
        vc = ((UITabBarController *)vc).selectedViewController;
        
        return (UITabBarController *)vc;
    }
    return nil;
}
- (UINavigationController *)currentNavigationController {
    
    return [self currentViewConroller].navigationController;
}
@end
