//
//  HHGraphicsViewController.m
//  HHDrawView
//
//  Created by Mac on 2018/6/9.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHGraphicsViewController.h"

@interface HHGraphicsViewController ()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIImage *image;
@end

@implementation HHGraphicsViewController


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self drawImageContext];
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    }return _imgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawImageContext];
    [self.view addSubview:self.imgView];
//    self.imgView.image = [UIImage imageNamed:@"222.jpeg"];
    
}

#pragma mark -- 图片裁剪
/** 图片裁剪 */
- (void)clipImageContext {
    
}

#pragma mark -- 图片添加水印
/** 图片添加水印 */
- (void)drawImageContext {
    
    /**
        - 绘制图片到新的图片上，就需要用到位图上下文
        - 位图上下文不能获取，只能我们手动创建
        - 开启一个位图上下文和view无关联。因此不需要drawRect里面去书写代码
     */
    
    
    _image = [UIImage imageNamed:@"222.jpeg"];
    
    /** 开启位图上下文 */
    /**
     size : 图片尺寸
     opaque : 不透明度 YES:不透明 NO:透明 通常为NO
     scale : 缩放上下文 0:不缩放 通常为0
     */
    UIGraphicsBeginImageContextWithOptions(_image.size, NO, 0);
    
    /** 1、绘制原生图片 */
    [_image drawAtPoint:CGPointZero];
    
    /** 2、给原生图片添加文字 */
    NSString *str = @"星空下的守候";
    [str drawAtPoint:CGPointMake(50, _image.size.height - 100) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor redColor]}];
    
    
    /** 获取上下文 只有有上下文 都能获取到 */
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 10, 0);
    CGContextAddLineToPoint(ctx, 100, 100);
    CGContextSetCMYKStrokeColor(ctx, 1, 0, 0, 0, 1);
    CGContextStrokePath(ctx);
    
    
    /** 3、生成一张图片 */
    _image = UIGraphicsGetImageFromCurrentImageContext();
    
    /** 4、关闭位图上下文 */
    UIGraphicsEndImageContext();
    
    self.imgView.image = _image;
}


@end
