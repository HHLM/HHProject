//
//  ViewController.m
//  HHDrawView
//
//  Created by Mac on 2018/6/8.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "ViewController.h"
#import "HHDrawViewController.h"
#import "HHGraphicsViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *titles;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
    [self.view addSubview:self.myTableView];
}

- (void)config {
    self.title = @"Quartz2D";
    self.navigationController.navigationBar.translucent = NO;
    _titles= @[@[@"画线",@"画矩形",@"画圆形",@"画文字",@"画图片",@"圆形进度条和饼状图",@"柱状图📊",@"涂鸦"],
               @[@"图片水印",@"圆形图片剪切",@"带圆环的圆形图片剪切",@"屏幕截图",@"手动选择区域截图",@"图片擦除",@"画板"]];
}
- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _titles.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titles[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = _titles[indexPath.section][indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        HHDrawViewController *vc = [[HHDrawViewController alloc] init];
        vc.title = _titles[indexPath.section][indexPath.row];
        vc.index = indexPath.row;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        HHGraphicsViewController *vc = [[HHGraphicsViewController alloc] init];
        vc.index = indexPath.row;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

@end
