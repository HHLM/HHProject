//
//  HHShowViewController.m
//  HHWeChatFloatView
//
//  Created by Mac on 2018/7/4.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHShowViewController.h"
#import "HHAnimation.h"
#import "HHManager.h"
@interface HHShowViewController ()<UINavigationControllerDelegate>

@end

@implementation HHShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[HHManager shareManager].floatArray removeAllObjects];
    [[HHManager shareManager].floatArray addObject:@"HHShowViewController"];
    
    NSLog(@"++++++++++++++++++");
    self.view.backgroundColor =[UIColor greenColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" ••• " style:UIBarButtonItemStylePlain target:self action:@selector(showAlert)];
   
}

- (void)showAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"浮窗" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[HHManager shareManager] showFloatView];
        [HHManager shareManager].floatViewController = self;;
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
