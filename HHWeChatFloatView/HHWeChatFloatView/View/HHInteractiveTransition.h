//
//  HHInteractiveTransition.h
//  HHWeChatFloatView
//
//  Created by Mac on 2018/8/3.
//  Copyright © 2018年 Now. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHInteractiveTransition : UIPercentDrivenInteractiveTransition

@property(nonatomic, assign)BOOL isInteractive;

@property(nonatomic, assign)CGPoint curPoint;

- (void)transitionToViewController:(UIViewController *)toViewController;

@end
