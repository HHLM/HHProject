//
//  BaseViewController.m
//  UIAlertViewController
//
//  Created by Mac on 2018/5/30.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "BaseViewController.h"




@interface BaseViewController ()
@property (nonatomic, strong) UILabel *titleLab;
@end

@implementation BaseViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.transparence) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new]forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [UIImage new];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //只有导航透明度变化的页面 才会添加自定义导航
    if (self.transparence) {
        [self addCustomNavBar];
    }
}

- (void)addCustomNavBar {
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), HNavBarHeight)];
    self.navBarView = navView;
    [self.view addSubview:navView];
    navView.backgroundColor = [UIColor whiteColor];
    self.navBarAlpha = 0;
    /** 展示在最上层 */
    navView.layer.zPosition = 1;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(40, HStatueBarHeight + 6, CGRectGetWidth(self.view.frame)-80, 30)];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLabel];
    self.titleLab = titleLabel;
}

- (void)setNavBarColor:(UIColor *)navBarColor {
    self.navBarView.backgroundColor = navBarColor;
}

- (void)setNavBarAlpha:(CGFloat)navBarAlpha {
    self.navBarView.alpha = navBarAlpha;
}

- (void)setTitleStr:(NSString *)titleStr {
    self.titleLab.text = titleStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
