//
//  HHBaseViewController.m
//  HHMasonryDemo
//
//  Created by Mac on 2018/6/2.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHBaseViewController.h"

@interface HHBaseViewController ()

@end

@implementation HHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
    [self updateMainUI];
}

- (void)config {
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)updateMainUI {
    
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
