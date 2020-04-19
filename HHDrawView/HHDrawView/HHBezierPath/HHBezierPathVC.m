//
//  HHBezierPathVC.m
//  HHDrawRectDemo
//
//  Created by LXH on 2017/6/27.
//  Copyright © 2017年 HHLM. All rights reserved.
//

#import "HHBezierPathVC.h"
#import "HHBezierPathView.h"
@interface HHBezierPathVC ()
@property (nonatomic, strong) HHBezierPathView *bezierView;
@end

@implementation HHBezierPathVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bezierView];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view addSubview:self.bezierView];
}

- (HHBezierPathView *)bezierView {
    if (!_bezierView) {
        _bezierView = [[HHBezierPathView alloc] initWithFrame:self.view.bounds];
        _bezierView.backgroundColor = [UIColor whiteColor];
    }return _bezierView;
}

@end
