//
//  ViewController.m
//  HHFloatView
//
//  Created by Mac on 2018/6/6.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "ViewController.h"

#import "EOCNextViewController.h"

@interface UINavigationController (EOC)

@end

@implementation UINavigationController (EOC)

- (UIViewController *)childViewControllerForStatusBarStyle {
    
    if (self.navigationController.topViewController == self.childViewControllers[0]) {
        return self.childViewControllers[0];
    }
    
    return self.childViewControllers.lastObject;
    
}

@end

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *table;

@end

@implementation ViewController

//在页面即将出现的时候 设置为透明
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self customNavigationBar];
    
    [self.view addSubview:self.table];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
    
}

#pragma mark - 自定义导航栏
- (void)customNavigationBar {
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, [UIScreen mainScreen].bounds.size.width, 64.f)];
    navView.backgroundColor = [UIColor colorWithRed:74.f/255.f green:74.f/255.f blue:74.f/255.f alpha:1.f];
    
    [self.view addSubview:navView];
    
}


#pragma mark - UITableView delegate && datasource method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    cell.textLabel.text = @"八点钟学院";
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay://"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"alipay://"] options:nil completionHandler:^(BOOL success) {
            
        }];
    }
    EOCNextViewController *nextViewCtrl = [EOCNextViewController new];
    [self.navigationController pushViewController:nextViewCtrl animated:YES];
    
}

#pragma mark - UITableView getter method
- (UITableView *)table {
    
    if (!_table) {
        
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 64.f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        
    }
    
    return _table;
}



@end
