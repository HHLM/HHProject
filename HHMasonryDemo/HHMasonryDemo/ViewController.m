//
//  ViewController.m
//  HHMasonryDemo
//
//  Created by Mac on 2018/6/2.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "ViewController.h"
#import "HHBaseView.h"
#import "HHHeadView.h"
#import "HHNextViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *titles;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HHHeadView *headView;
@property (nonatomic, strong) UILabel *headLable;
@property (nonatomic, strong) HHBaseView *topView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView layoutIfNeeded];
    self.tableView.tableHeaderView = self.headView;
    self.topView = [HHBaseView new];
    self.topView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.topView];
    [self.topView layoutIfNeeded];
}

- (void)config {
    [super config];
    self.navigationItem.title = @"Masonry";
    
    titles = @[@"同一个控件宽高成比例"];
}



- (void)updateMainUI {
    [super updateMainUI];
    [self.view addSubview:self.tableView];
    self.headView = [HHHeadView new];
    [self.tableView setTableHeaderView:self.headView];
    self.headView.backgroundColor = [UIColor redColor];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(self.view.mas_width);
    }];
    self.headView.titleString = @"那时的我们拥有\n没有污染过的清晨\n嘀嘀嗒嗒的秒针\n却留不住一个黄昏\n曾经的爱很简单\n不需要费力的眼神\n牵手走过无人山岗\n想时间再慢几分\n怀念啊我们的青春啊\n昨天在记忆里生根发芽\n爱情滋养心中那片土地\n绽放出美丽不舍的泪花\n怀念啊我们的青春啊";
    
    
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titles.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = titles[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HHNextViewController *vc = [[HHNextViewController alloc] init];
    vc.title = titles[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
