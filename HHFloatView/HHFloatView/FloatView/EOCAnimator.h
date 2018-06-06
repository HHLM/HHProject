//
//  EOCAnimator.h
//  微信浮窗一  公开课
//
//  Created by 八点钟学院 on 2018/6/5.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EOCAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property(nonatomic, assign)UINavigationControllerOperation operation;

@end
