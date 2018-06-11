//
//  HHDrawTopView.m
//  HHDrawView
//
//  Created by Mac on 2018/6/11.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHDrawTopView.h"

@interface HHDrawTopView() <UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *tipsLab;
@end

@implementation HHDrawTopView


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (CGRectContainsPoint(self.imgView.frame, point)) {
        NSLog(@"点在imageView上");
        return self.imgView;
    }
    return self.imgView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.imgView];
        [self addSubview:self.tipsLab];
        [self addGestureRecognizer];
    }
    return self;
}

- (UILabel *)tipsLab {
    if (!_tipsLab) {
        _tipsLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.width, 20)];
        _tipsLab.text = @"亲、编辑完图片记得长按保存哦！！！！";
        _tipsLab.textAlignment = NSTextAlignmentCenter;
    }return _tipsLab;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imgView.userInteractionEnabled = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    }return _imgView;
}

- (void)setImage:(UIImage *)image {
    self.imgView.image = image;
}

- (void)addGestureRecognizer {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.imgView addGestureRecognizer:pan];
    
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    rotation.delegate = self;
    [self.imgView addGestureRecognizer:rotation];
    
    UIPinchGestureRecognizer  *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    pinch.delegate = self;
    [self.imgView addGestureRecognizer:pinch];
    
    UILongPressGestureRecognizer  *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress)];
    [self.imgView addGestureRecognizer:longPress];
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    
    /** 获取触控点 */
    CGPoint point = [pan locationInView:self.imgView];
    
    NSLog(@"触控点：%@",NSStringFromCGPoint(point));
    /** 获取偏移点 */
    CGPoint transformPoint = [pan translationInView:self.imgView];
    
     NSLog(@"偏移点：%@",NSStringFromCGPoint(transformPoint));
    
    self.imgView.transform = CGAffineTransformTranslate(self.imgView.transform, transformPoint.x, transformPoint.y);
    /** 只要相对于上一次 就必须复位  要把手势的偏移量清空*/
    [pan setTranslation:CGPointZero inView:self.imgView];
    
}
- (void)rotation:(UIRotationGestureRecognizer *)rotation  {
    self.imgView.transform = CGAffineTransformRotate(self.imgView.transform, rotation.rotation);
    NSLog(@"-------旋转角度：%f",rotation.rotation);
    /** 在原来的基础上旋转 就要复位为0 因为随着旋转 rotation 越来越大 会出现旋转速度越来越快的效果 */
    rotation.rotation = 0;
}

- (void)pinch:(UIPinchGestureRecognizer *)pinch {
    self.imgView.transform = CGAffineTransformScale(self.imgView.transform, pinch.scale, pinch.scale);
   NSLog(@"++++++++++缩放大小：%f",pinch.scale);
    /** 在原来的基础上缩放 就要复位为1 因为随着旋转 scale 越来越大  */
    pinch.scale = 1;
}

//长按有个高亮状态 并且把图片保存到 画板上去
- (void)longPress {
    /** 高亮效果 */
    [UIView animateWithDuration:0.25 animations:^{
        self.imgView.alpha = 0;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            self.imgView.alpha = 1;
        } completion:^(BOOL finished) {
            [self drawImage];
        }];
    } ];
}

- (void)drawImage {
    //截图之前要先把tips信息去掉
    self.tipsLab.hidden = YES;
    [self.tipsLab removeFromSuperview];
    
    /** 开启图形上下文 */
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    
    /** 回去图形上下文 */
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    /** layer 渲染到图形上下文*/
    [self.layer renderInContext:ctx];
    
    /** 从图形上下文获取图片 */
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    /** 关闭图形上下文 */
    UIGraphicsEndImageContext();
    
    if (_block) {
        _block(image);
        [self removeFromSuperview];
    }
}

#pragma mark -- UIGestureRecognizerDelegate
/** 可以和其他手势一起使用 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer; {
    return YES;
}

@end
