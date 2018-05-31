//
//  HHView.m
//  UIAlertViewController
//
//  Created by Mac on 2018/5/30.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHView.h"
#import "AlertHelp.h"
@implementation HHView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)showAlert {
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

@end
