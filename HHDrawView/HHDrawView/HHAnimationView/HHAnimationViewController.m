//
//  HHAnimationViewController.m
//  HHDrawView
//
//  Created by Mac on 2018/6/11.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHAnimationViewController.h"
#import "HHAnimationView.h"
@interface HHAnimationViewController ()

@end

@implementation HHAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HHAnimationView *animationView = [[HHAnimationView alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
    animationView.center = self.view.center;
    [self.view addSubview:animationView];
}


@end
