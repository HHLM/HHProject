//
//  ViewController.m
//  UIAlertViewController
//
//  Created by Mac on 2018/5/30.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "ViewController.h"
#import "AlertHelp.h"
#import "HHView.h"
#import "HHNextViewController.h"
@interface ViewController ()
@property (nonatomic, strong) HHView *alertView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HHView *alert = [[HHView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.alertView = alert;
    [self.view addSubview:alert];
    
}
- (IBAction)alertshow:(id)sender {
    
    AlertActionHandle sureHandle = ^(UIAlertAction *_Nonnull action){
        NSLog(@"点击了确定按钮");
    };
    
    [AlertHelp alertWith:@"这是标题"
                 message:@"这是消息内容哈哈哈"
                 funBtns:@{@"确定":sureHandle}
               cancelBtn:@"取消"
              alertStyle:UIAlertControllerStyleAlert
            cancelAction:nil];
}
- (IBAction)alertshow1:(id)sender {
    
    AlertActionHandle sureHandle = ^(UIAlertAction *_Nonnull action){
        NSLog(@"点击了按钮一");
    };
    AlertActionHandle cancleHandle = ^(UIAlertAction *_Nonnull action){
        NSLog(@"点击了按钮二");
    };
    [AlertHelp alertWith:@"这是标题"
                 message:@"这是消息内容哈哈哈"
                 funBtns:@{@"按钮一":sureHandle,@"按钮二":cancleHandle}
               cancelBtn:@"取消"
              alertStyle:UIAlertControllerStyleAlert
            cancelAction:nil];
}
- (IBAction)alertshow2:(id)sender {
    AlertActionHandle sureHandle = ^(UIAlertAction *_Nonnull action){
        NSLog(@"点击了按钮一");
    };
    AlertActionHandle cancleHandle = ^(UIAlertAction *_Nonnull action){
        NSLog(@"点击了按钮二");
    };
    [AlertHelp alertWith:@"这是标题"
                 message:@"这是消息内容哈哈哈"
                 funBtns:@{@"按钮一":sureHandle,@"按钮二":cancleHandle}
               cancelBtn:@"取消"
              alertStyle:UIAlertControllerStyleActionSheet
            cancelAction:nil];
}
- (IBAction)alertshow3:(id)sender {
    [AlertHelp tipWith:@"弹出一个框框" wait:1.2f];
}
- (IBAction)alertshow4:(id)sender {
    
    [AlertHelp alertWith:@"HHH"
                 message:@"HHHHHH"
                 funBtns:@{}
               cancelBtn:@"取消"
          destructiveBtn:@"哈哈哈"
              alertStyle:UIAlertControllerStyleAlert
            cancelAction:^(UIAlertAction * _Nonnull action) {
        
    } destrutiveAction:^(UIAlertAction * _Nonnull action) {
        
    }];
}

- (IBAction)alertshow5:(id)sender {
    
    AlertActionHandle beautyBlock = ^(UIAlertAction *_Nonnull action){
        
    };
    AlertActionHandle fennenBlock = ^(UIAlertAction *_Nonnull action){
        
    };
    AlertActionHandle huaijiuBlock = ^(UIAlertAction *_Nonnull action){
        
    };
    AlertActionHandle landiaoBlock = ^(UIAlertAction *_Nonnull action){
      
    };
    AlertActionHandle langmanBlock = ^(UIAlertAction *_Nonnull action){
        
    };
    AlertActionHandle qingliangBlock = ^(UIAlertAction *_Nonnull action){
       
    };
    AlertActionHandle qingxinBlock = ^(UIAlertAction *_Nonnull action){
       
    };
    AlertActionHandle rixiBlock = ^(UIAlertAction *_Nonnull action){
        
    };
    AlertActionHandle weimeiBlock = ^(UIAlertAction *_Nonnull action){
       
    };
    NSDictionary *funs = @{@"美颜美白":beautyBlock,
                           @"粉嫩":fennenBlock,
                           @"怀旧":huaijiuBlock,
                           @"蓝调":landiaoBlock,
                           @"浪漫":langmanBlock,
                           @"清凉":qingliangBlock,
                           @"清新":qingxinBlock,
                           @"日系":rixiBlock,
                           @"唯美":weimeiBlock};
    
    [AlertHelp alertWith:@"我是标题"
                 message:@"我是内容"
                 funBtns:funs
               cancelBtn:@"取消"
          destructiveBtn:@"清空滤镜"
              alertStyle:UIAlertControllerStyleAlert
            cancelAction:nil
        destrutiveAction:^(UIAlertAction * _Nonnull action) {
        
    }];
    
}
- (IBAction)alertViewShow:(id)sender {
    [self.alertView showAlert];
}
- (IBAction)pushNavBar:(id)sender {
    HHNextViewController *vc = [[HHNextViewController alloc] init];
    vc.transparence = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
