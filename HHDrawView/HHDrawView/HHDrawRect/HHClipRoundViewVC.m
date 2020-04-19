//
//  HHClipRoundViewVC.m
//  HHDrawRectDemo
//
//  Created by LXH on 2017/6/28.
//  Copyright © 2017年 HHLM. All rights reserved.
//

#import "HHClipRoundViewVC.h"
#import "HHClipRoundView.h"
@interface HHClipRoundViewVC ()
@property (nonatomic, strong) HHClipRoundView *clipView;
@end

@implementation HHClipRoundViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.contents = (id)[UIImage imageNamed:@"11.jpg"].CGImage;
    [self.view addSubview:self.clipView];
}

-  (HHClipRoundView *)clipView {
    if (!_clipView) {
        _clipView = [[HHClipRoundView alloc] initWithFrame:self.view.bounds];
        _clipView.backgroundColor = [UIColor clearColor];
    }return _clipView;
}
@end
