//
//  HHDrawImageView.m
//  HHDrawDemo
//
//  Created by Mac on 2018/6/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "HHDrawImageView.h"

@implementation HHDrawImageView
{
    UIImage *imageN;
}

- (instancetype)initWithImage:(UIImage *)image {
    if ([super initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)]) {
        _image = image;
        [self setNeedsDisplay];
    }return self;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    if (_image) {
        [_image drawInRect:rect];
    }else {
        [self addDrawImage1];
        [self addDrawImage2];
        [self addDrawImage3];
        [self addDrawImage4];
        [self addDrawImage5];
    }
    
   
}
- (void)addDrawImage1 {
    
    UIImage *image = [UIImage imageNamed:@"自动止损止盈提醒"];
  
    /** 图片多大 就会绘制多大  */
    [image drawAtPoint:CGPointMake(20, 20)];
}

- (void)addDrawImage2 {
    
    UIImage *image = [UIImage imageNamed:@"自动止损止盈提醒"];
    if (!imageN) {
        imageN = image;
    }
    /** 绘制到规定区域内  会拉伸填满整个区域*/
    [imageN drawInRect:CGRectMake(200, 20, 100, 80)];
}

- (void)addDrawImage3 {
    
    UIImage *image = [UIImage imageNamed:@"自动止损止盈提醒"];
    /** 绘制到规定区域内  会平铺整个区域*/
    [image drawAsPatternInRect:CGRectMake(20, 100, 100, 80)];
}

- (void)addDrawImage4 {
    
    UIImage *image = [UIImage imageNamed:@"组6拷贝5"];
    /** 绘制到规定区域内  会平铺整个区域*/
//    [image drawAsPatternInRect:CGRectMake(20, 100, 100, 80)];
    [image drawInRect:CGRectMake(20, 200, 200, 100) blendMode:kCGBlendModeMultiply alpha:0.5];
}

- (void)addDrawImage5 {
    
    UIImage *image = [UIImage imageNamed:@"yy_read_s"];
    /** 裁剪图片*/
    UIRectClip(CGRectMake(20, 320,60, 60));
    [image drawAsPatternInRect:CGRectMake(20, 320, 200, 80)];
    
}
- (void)addDrawImage6 {
    
    UIImage *image = [UIImage imageNamed:@"yy_read_s"];
    /** 绘制到规定区域内  会平铺整个区域*/
    [image drawAsPatternInRect:self.bounds];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    imageN = [UIImage imageNamed:@"微信图片_20180521182112"];
    [self setNeedsDisplay];
}

@end
