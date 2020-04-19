//
//  HHPaintVC.m
//  HHDrawRectDemo
//
//  Created by LXH on 2017/6/26.
//  Copyright © 2017年 HHLM. All rights reserved.
//

#import "HHPaintVC.h"
#import "HHPaintView.h"
@interface HHPaintVC ()
@property (nonatomic, strong) HHPaintView *paintView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *middleBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@end

@implementation HHPaintVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"涂鸦一下吧";
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.leftBtn];
    [self.view addSubview:self.middleBtn];
    [self.view addSubview:self.rightBtn];
    [self.view addSubview:self.paintView];
}

- (void)clear {
    [self.paintView clear];
}
- (void)back {
    [self.paintView back];
}
- (void)save {
    UIImage *image = [self makeImageWithView:self.paintView withSize:self.paintView.frame.size];
    //保存图片
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image: didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {//保存失败
        NSLog(@"保存成功");
    }else{//保存成功
         NSLog(@"保存失败");
    }
    
}

- (HHPaintView *)paintView {
    if (!_paintView) {
        _paintView = [[HHPaintView alloc] initWithFrame:CGRectMake(0, 104, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-104)];
        _paintView.backgroundColor = [UIColor whiteColor];
        _paintView.paintWidth = 2;
        _paintView.paintColor = [UIColor greenColor];
    }return _paintView;
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setFrame:CGRectMake(10, 64, 60, 40)];
        [_leftBtn setTitle:@"清除" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)middleBtn {
    if (!_middleBtn) {
        _middleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_middleBtn setFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 -30, 64, 60, 40)];
        [_middleBtn setTitle:@"退后" forState:UIControlStateNormal];
        [_middleBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_middleBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _middleBtn;
}
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setFrame:CGRectMake(CGRectGetWidth(self.view.frame)-70, 64, 60, 40)];
        [_rightBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}


#pragma mark 生成image


- (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size {
    
     // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}



@end
