//
//  HHNextViewController.m
//  HHMasonryDemo
//
//  Created by Mac on 2018/6/2.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHNextViewController.h"

@interface HHNextViewController ()

@end

@implementation HHNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        //设置高和宽的比例是 12:9
        make.height.mas_equalTo(topView.mas_width).multipliedBy(12/9.0);
    }];
    
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor cyanColor];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        //相对于superviewde上左下右边距分别为20，20，20，20
        make.edges.equalTo(topView).insets(UIEdgeInsetsMake(20, 20, 20, 20));
    }];
    
    label.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    label.text = @"1、设置绿色的背景View 宽高成比例是12:9;\n 2、让lable旋转90°";
    
}

- (void)config {
    [super config];
}

- (void)updateMainUI {
    [super updateMainUI];
}

@end
