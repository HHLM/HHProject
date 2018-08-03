//
//  HHAnimation.h
//  HHWeChatFloatView
//
//  Created by Mac on 2018/7/5.
//  Copyright © 2018年 Now. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HHFloatView.h"
@interface HHAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) HHFloatView *floatView;
@property (nonatomic, assign) UINavigationControllerOperation operation;
@property (nonatomic, assign) BOOL isInteractive;

@end
