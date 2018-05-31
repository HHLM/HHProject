//
//  HHThirdViewController.m
//  UIAlertViewController
//
//  Created by Mac on 2018/5/30.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHThirdViewController.h"
@interface HHThirdViewController ()

@end

@implementation HHThirdViewController

- (void)viewWillAppear:(BOOL)animated {
//    UINavigationBar *bar = self.navigationController.navigationBar;
//    [bar setNavBarHeight:  88];
//    CGRect rect = self.navigationController.navigationBar.frame;
//    NSLog(@"%@",NSStringFromCGRect(rect));
//    //调整导航栏标题的位置
//    [bar setTitleVerticalPositionAdjustment:-44 forBarMetrics:UIBarMetricsDefault];
//    
//    //调整导航栏按钮的位置
//    UIBarButtonItem *item = self.navigationItem.leftBarButtonItem;
//    [item setBackgroundVerticalPositionAdjustment:-44 forBarMetrics:UIBarMetricsDefault];
//    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
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
