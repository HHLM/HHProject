//
//  HHGraphicsViewController.m
//  HHDrawView
//
//  Created by Mac on 2018/6/9.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHGraphicsViewController.h"
#import "HHDrawBoardViewController.h"
#import "AppDelegate.h"
@interface HHGraphicsViewController ()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGPoint starPoint;
@property (nonatomic, strong) UIView *currentView;
@property (nonatomic, strong) UIImageView *topImgView;

@end

@implementation HHGraphicsViewController


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_index == 0) {
         [self drawImageContext];
    }else if(_index == 6) {
        [self drawBoard];
    }
}
- (UIView *)currentView {
    if (!_currentView) {
        _currentView = [[UIView alloc] init];
        _currentView.backgroundColor = [UIColor redColor];
        _currentView.alpha = 0.3;
        [self.view addSubview:_currentView];
    }return _currentView;
}
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _imgView.backgroundColor = [UIColor cyanColor];
    }return _imgView;
}
- (UIImageView *)topImgView {
    if (!_topImgView) {
        _topImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _topImgView.backgroundColor = [UIColor clearColor];
    }return _topImgView;
}
- (void)respondsSelectorIndex:(NSInteger)index {
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"imageContext%ld",index]);
    if (selector) {
        IMP imp =  [self methodForSelector:selector];
        void(*func)(id,SEL) = (void *)imp;
        func(self,selector);
    }
    [self updateImageView];
}
- (void)imageContext0 {
    _imgView.contentMode = UIViewContentModeCenter;
    [self drawImageContext];
}
- (void)imageContext1 {
    [self clipImageContext];
    
}
- (void)imageContext2 {
    [self clipRoundImage];
}

- (void)imageContext3 {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self screenShot:app.window];
}
- (void)imageContext4 {
    [self customScreenShot];
}
- (void)imageContext5 {
    [self claerPicture];
}
- (void)imageContext6 {
    [self drawBoard];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imgView];
    [self respondsSelectorIndex:_index];
}
/** 更新 */
- (void)updateImageView {
    self.imgView.image = _image;
}

#pragma mark -- 画板
- (void)drawBoard {
    HHDrawBoardViewController *vc = [[HHDrawBoardViewController alloc] init];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

#pragma mark -- 擦除图片

- (void)claerPicture {
    [self.view addSubview:self.topImgView];
    self.topImgView.image = [UIImage imageNamed:@"222.jpeg"];
    _image = [UIImage imageNamed:@"111.jpg"];
    self.imgView.image = _image;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
}
- (void)pan:(UIPanGestureRecognizer *)pan {
    CGPoint starP = [pan locationInView:self.view];
    CGFloat maxW = 30.0;
    CGRect rect = CGRectMake(starP.x-maxW/2, starP.y-maxW/2, maxW, maxW);
    
    /** 开启位图图形上下文 */
    UIGraphicsBeginImageContextWithOptions(self.topImgView.frame.size, NO, 0);
    /** 获取图形上下文 */
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //渲染到图形上下文
    [self.topImgView.layer renderInContext:ctx];
    //清除区域内的图片
    CGContextClearRect(ctx, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    self.topImgView.image = image;
    UIGraphicsEndImageContext();
    
}


#pragma mark --  手动截图
- (void)customScreenShot {
    
    _image = [UIImage imageNamed:@"111.jpg"];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panCustomRect:)];
    [self.view addGestureRecognizer:pan];
}
- (void)panCustomRect:(UIPanGestureRecognizer *)pan {
    
    CGPoint endPoint;
    //开始时候获取起始坐标
    if (pan.state == UIGestureRecognizerStateBegan) {
        _starPoint = [pan locationInView:self.view];
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        endPoint = [pan locationInView:self.view];
        CGFloat w = endPoint.x - _starPoint.x;
        CGFloat h = endPoint.y - _starPoint.y;
        //获取选取图片区域
        [self.currentView setFrame:CGRectMake(_starPoint.x, _starPoint.y, w, h)];
    }else {
        UIGraphicsBeginImageContextWithOptions(self.imgView.frame.size, false, 0);
        
        //裁剪区域 选择区域的大小
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.currentView.frame];
        [path addClip];
        //获取图形上下文
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        //渲染到图形上下文
        [self.imgView.layer renderInContext:ctx];
        
        _image  = UIGraphicsGetImageFromCurrentImageContext();
        
        self.imgView.image = _image;
        /** 关闭图形上下文 */
        UIGraphicsEndImageContext();
        /** 移除选择区域框 */
        [_currentView removeFromSuperview];
        
        _currentView = nil;
    }
    
}

#pragma mark -- 屏幕截屏
/** 屏幕截屏 */
- (void)screenShot:(UIView *)view {

    _image = [UIImage screenShotView:view contentRect:CGRectMake(0, 64, self.view.width,400)];
    _image = [UIImage screenShotView:view];
    
    //转成png图片  比较清晰
    //NSData *data = UIImagePNGRepresentation(_image);
    
    //保存图片到某个位置
    //[data writeToFile:@"/Users/mac/Desktop/PAN/hh.png" atomically:YES];
    
    
}

#pragma mark -- 截取带圆环的图片
/** 截取圆环图片 */
- (void)clipRoundImage {
    _imgView.frame = CGRectMake(0,100, self.view.width, self.view.width);
    UIImage *image = [UIImage imageNamed:@"111.jpg"];
    _image = [UIImage clipCirqueImage:image cirqueColor:[UIColor purpleColor] border:10];
}

#pragma mark -- 图片裁剪
/** 图片裁剪 */
- (void)clipImageContext {
    self.imgView.frame = CGRectMake(0, 100, self.view.width, self.view.width);
    UIImage *image = [UIImage imageNamed:@"222.jpeg"];
    _image = [UIImage clipRoundImage:image scacle:-0.6];
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
