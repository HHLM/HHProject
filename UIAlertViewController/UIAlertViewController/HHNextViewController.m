//
//  HHNextViewController.m
//  UIAlertViewController
//
//  Created by Mac on 2018/5/30.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHNextViewController.h"
#import "HHThirdViewController.h"

@interface HHNextViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *topView;
@end

@implementation HHNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBarColor = [UIColor greenColor];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.titleStr = @"我就是我不一样的烟火";
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    [self.tableView setTableHeaderView:self.headView];
    
}
- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200)];
        _headView.backgroundColor = [UIColor redColor];
        [_headView addSubview:self.topView];
    }return _headView;
}
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:self.headView.bounds];
        _topView.backgroundColor = [UIColor cyanColor];
        UIView *roundView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2-50, 100, 100, 100)];
        roundView.backgroundColor = [UIColor redColor];
        [_topView addSubview:roundView];
    }return _topView;
}
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"我就是单元格 服气不！";
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HHThirdViewController *vc = [[HHThirdViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    
//    NSLog(@"%f",offsetY);
    
    if (offsetY >= 0)
    {
        //header 高度 - 导航高度
        CGFloat alpha = offsetY/ (200 - HNavBarHeight);
        
        NSLog(@"透明度：%f",alpha);
        
        self.navBarAlpha = alpha;
        
    } else {
        self.navBarAlpha = 0;
    }
    
    CGFloat scale = (200 -offsetY)/200;
    
    scale = (scale > 1) ? scale : 1;
    
    NSLog(@"放大倍数：%f",scale);
    
    /** 根据偏移放大 */
    self.topView.transform = CGAffineTransformMakeScale(scale, scale);
    
    CGRect rect = self.topView.frame;
    
    /** 设置y坐标 当放大倍数是 1 的时候  说明向上滑动的 这就要跟随tableView滑动了 此时y坐标应该是0  */
   
    CGFloat originY = (scale > 1) ? offsetY : 0;
    
    rect.origin.y = originY;
    
    self.topView.frame = rect;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}


@end
