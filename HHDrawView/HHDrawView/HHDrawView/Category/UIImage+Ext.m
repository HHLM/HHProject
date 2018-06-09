//
//  UIImage+Ext.m
//  HHDrawView
//
//  Created by Mac on 2018/6/9.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "UIImage+Ext.h"

@implementation UIImage (Ext)


/**
 截取一个圆形图片

 @param image 图片
 @param rect 截取区域
 @return imaage
 */
+ (UIImage *)creatImage:(UIImage *)image rect:(CGRect)rect {
    
    /** 不是正方形图形才切图 */
    if (image.size.width != image.size.height) {
        /** 2、在原来图片的基础上 把原图截取成一个正方形图片 */
        CGImageRef ref = [image CGImage];
        ref = CGImageCreateWithImageInRect(ref, rect);
        image = [UIImage imageWithCGImage:ref];
    }
    
    /** size 图形上下文的大小 */
    UIGraphicsBeginImageContextWithOptions(image.size, false, 0);
    
    /** 3、添加剪切图片的区域 */
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    [path addClip];
    
    /** 4、绘图 */
//    [image drawInRect:CGRectMake(0,0, wid, wid)];
    [image drawAtPoint:CGPointZero];
    
    /** 5、获取图片 */
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    /** 6、关闭图形上下文 */
    UIGraphicsEndImageContext();
    
    return image;
}

/** 否截取图片中间的部分 相对于中心的位置 scale [-1,1]、scale < 0 偏向左或偏上 scale > 0 偏向下或者偏右 */
+ (UIImage *)clipRoundImage:(UIImage *)image scacle:(CGFloat)scacle {
    /** 1、判断图片的大小获取一个 正方形的图片尺寸大小 */
    CGFloat wid = image.size.width > image.size.height ? image.size.height : image.size.width;
    CGFloat x = image.size.width > image.size.height ? (image.size.width - image.size.height)/2 : 0;
    CGFloat y = image.size.width > image.size.height ? 0 : (image.size.height - image.size.width)/2;
    
    x = x ? (x + scacle * x) : 0;
    y = y ? (y + scacle * y) : 0;
    return [UIImage creatImage:image rect:CGRectMake(x, y, wid, wid)];
}

+ (UIImage *)clipRoundImage:(UIImage *)image center:(BOOL)center {
    
    /** 1、判断图片的大小获取一个 正方形的图片尺寸大小 */
    CGFloat wid = image.size.width > image.size.height ? image.size.height : image.size.width;
    CGFloat x = image.size.width > image.size.height ? (image.size.width - image.size.height)/2 : 0;
    CGFloat y = image.size.width > image.size.height ? 0 : (image.size.height - image.size.width)/2;
    
    x = center ? x : 0;
    y = center ? y : 0;
    
    return [UIImage creatImage:image rect:CGRectMake(x, y, wid, wid)];
   
}

+ (UIImage *)clipRoundImage:(UIImage *)image {
    return [UIImage clipRoundImage:image center:NO];
}

#pragma mark -- 带圆环的圆形图片

#pragma -- 换圆环的圆形图片

/**
 切一个带圆环的图片 默认圆环宽度是 2
 
 @param image 图片
 @param cirqueColor 圆环颜色
 @return image
 */
+ (UIImage *)clipCirqueImage:(UIImage *)image cirqueColor:(UIColor *)cirqueColor {
    return [UIImage clipCirqueImage:image cirqueColor:cirqueColor border:2];
}

/**
 切一个带圆环的图片
 @param image 图片
 @param cirqueColor 圆环颜色
 @param border 圆环宽度
 @return image
 */
+ (UIImage *)clipCirqueImage:(UIImage *)image cirqueColor:(UIColor *)cirqueColor border:(CGFloat)border {
    
    CGFloat wid = image.size.width > image.size.height ? image.size.height : image.size.width;
    CGFloat x = image.size.width > image.size.height ? (image.size.width - image.size.height)/2 : 0;
    CGFloat y = image.size.width > image.size.height ? 0 : (image.size.height - image.size.width)/2;
    
    
    if (image.size.width != image.size.height) {
        /** 把原图截取成一个正方形图片 */
        CGImageRef ref = [image CGImage];
        ref = CGImageCreateWithImageInRect(ref, CGRectMake(x, y, wid, wid));
        image = [UIImage imageWithCGImage:ref];
    }
    
    /** 位图的图形上下文 */
    UIGraphicsBeginImageContextWithOptions(image.size, false, 0);
    
    /** 添加红色背景图 为了展示图片的圆环 */
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.width)];
    [cirqueColor set];
    [roundPath fill];
    
    /** 图片要剪切的路径 */
    UIBezierPath *clipPath =[UIBezierPath bezierPathWithOvalInRect:CGRectMake(border, border, image.size.width - 2*border, image.size.width - 2*border)];
    [clipPath addClip];
    
    /** 把图片画到 图形上下文 */
    [image drawInRect:CGRectMake(border,border, image.size.width - 2*border, image.size.width - 2*border)];
    
    /** 获取图片 */
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    /** 关闭图形上下文 */
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark -- 截屏

/**
 截取某个控件图形
 @param view 需要被截取的控件
 @return image
 */
+ (UIImage *)screenShotView:(UIView *)view {
    
    /** 开启位图图形上下文 */
    UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0);
    
    /** 获取图形上下文 */
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    /** view渲染到图形上下文 */
    [view.layer renderInContext:ctx];
    
    /** 得到图片 */
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    /** 关闭位图图形上下文 */
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 截取某个控件图形
 @param view 需要被截取的控件
 @param contentRect 截取需要的内容区域大小
 @return image
 */
+ (UIImage *)screenShotView:(UIView *)view contentRect:(CGRect)contentRect {
   
    
    /** 开启位图图形上下文 */
    UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0);
    
    /** 获取图形上下文 */
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    /** view渲染到图形上下文 */
    [view.layer renderInContext:ctx];
    
    /** 得到图片 */
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    /** 保存图片到某个地方 */
    NSData *data = UIImagePNGRepresentation(image);
    [data writeToFile:@"/Users/mac/Desktop/PAN/1.png" atomically:YES];
    
    
    //小于view的区域 就截图
    if ((view.frame.size.width > contentRect.size.width) || (view.frame.size.height > contentRect.size.height)) {
      
        UIGraphicsEndImageContext();
        
        CGImageRef ref = [image CGImage];
        
        CGFloat scale =  [UIScreen mainScreen].scale;
        
        CGRect clipRect = CGRectMake(scale*contentRect.origin.x, scale*contentRect.origin.y, scale*contentRect.size.width, scale*contentRect.size.height);
        
        ref = CGImageCreateWithImageInRect(ref,clipRect);
        
        image = [UIImage imageWithCGImage:ref];
       
        NSData *data = UIImagePNGRepresentation(image);
        
        [data writeToFile:@"/Users/mac/Desktop/PAN/2.png" atomically:YES];
        
        UIGraphicsEndImageContext();
        
    }else {
         UIGraphicsEndImageContext();
        return image;
    }
    return image;
}

/**
 截取scrollView全部内容
 @param scrollView 被截图的控件
 @return image
 */
+ (UIImage *)screenShotScrollView:(UIScrollView *)scrollView {
    
    CGFloat width = scrollView.bounds.size.width;
    
    CGFloat height = scrollView.bounds.size.height;
    
    CGPoint offset = scrollView.contentOffset;
    
    CGFloat contentHeight = scrollView.contentSize.height;
    
    CGSize size = CGSizeMake(width, contentHeight);
    
    // 可变数组
    NSMutableArray *images = [NSMutableArray array];
    
    while (contentHeight > 0) {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        
        [scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        [images addObject:image];
        
        CGFloat offsetY = offset.y;
        
        [scrollView setContentOffset:CGPointMake(0, offsetY + height)];
        
        contentHeight -= height;
    }
    
    [images enumerateObjectsUsingBlock:^(UIImage * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj drawInRect:CGRectMake(0, idx * height, width, height)];
    }];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
