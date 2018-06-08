//
//  HHDrawViewController.m
//  HHDrawDemo
//
//  Created by Mac on 2018/6/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "HHDrawViewController.h"
#import "HHDrawLineView.h"
#import "HHDrawRectView.h"
#import "HHDrawRoundView.h"
#import "HHDrawTextView.h"
#import "HHDrawImageView.h"
#import "HHProgressView.h"
#import <objc/message.h>
@interface HHDrawViewController ()

@end

@implementation HHDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setIndex:(NSInteger)index {
    NSString *methodStr = [NSString stringWithFormat:@"addDrawView%ld",index];
    
#if 0
    
    char *methodName = (char *)[methodStr cStringUsingEncoding:NSUTF8StringEncoding];
    
    objc_msgSend(self,sel_registerName(methodName));

#else

    SEL sel = NSSelectorFromString(methodStr);
    
     /** 方法一 */
    if (sel) {
        ((void (*)(id, SEL))[self methodForSelector:sel])(self, sel);
    }
    
    /** 方法2
     if (sel) {
     [self performSelector:sel withObject:nil];
     }
     */
    
    /** 方法三
     IMP imp = [self methodForSelector:sel];
     void (*func)(id, SEL) = (void *)imp;
     func(self, sel);
     */
    
#endif
   
    
}
/** 画线 */
- (void)addDrawView0 {
    HHDrawLineView *view = [[HHDrawLineView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
}
/** 画矩形 */
- (void)addDrawView1 {
    HHDrawRectView *view = [[HHDrawRectView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
}
/** 画圆形 */
- (void)addDrawView2 {
    HHDrawRoundView *view = [[HHDrawRoundView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
}
/** 画文字 */
- (void)addDrawView3 {
    HHDrawTextView *view = [[HHDrawTextView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
}
/** 画图片 */
- (void)addDrawView4 {
    HHDrawImageView *view = [[HHDrawImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
}
/** 画圆形进度条 */
- (void)addDrawView5 {
    HHProgressView *view = [[HHProgressView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
}



@end
