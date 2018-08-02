//
//  HHAnimationViewController.m
//  HHDrawView
//
//  Created by Mac on 2018/6/11.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHAnimationViewController.h"
#import "HHAnimationView.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "HHClockView.h"
@interface HHAnimationViewController ()

@end

@implementation HHAnimationViewController

- (void)setIndex:(NSInteger)index {
    
    NSString *methodName = [NSString stringWithFormat:@"animation%ld",index];
    
#if 0
    
    char *name = (char *)[methodName cStringUsingEncoding:NSUTF8StringEncoding];
    
    objc_msgSend(self,sel_registerName(name));
  
#else
    
    SEL sel = NSSelectorFromString(methodName);
    
    IMP imp = [self methodForSelector:sel];
    
    void(*func)(id,SEL) = (void *)imp;
    
    func(self,sel);
    
#endif
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)animation0 {
    self.title = @"动画效果";
    HHAnimationView *animationView = [[HHAnimationView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 - 125, 25, 250, 250)];
    [self.view addSubview:animationView];
    
    HHAnimationView1 *animationView1 = [[HHAnimationView1 alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 - 150, 300, 300, 250)];
    [self.view addSubview:animationView1];
}
- (void)animation1 {
    self.title = @"时钟转动";
    HHClockView *clock = [[HHClockView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    clock.center = self.view.center;
    [self.view addSubview:clock];
}

@end
