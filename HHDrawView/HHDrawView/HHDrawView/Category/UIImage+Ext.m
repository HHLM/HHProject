//
//  UIImage+Ext.m
//  HHDrawView
//
//  Created by Mac on 2018/6/9.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "UIImage+Ext.h"

@implementation UIImage (Ext)
+ (UIImage *)clipRoundImage:(UIImage *)image {
    
    /** 1、判断图片的大小获取一个 正方形的图片尺寸大小 */
    CGFloat wid = image.size.width > image.size.height ?image.size.height:image.size.width;
    CGFloat x = image.size.width > image.size.height?(image.size.width - image.size.height)/2:0;
    CGFloat y = image.size.width > image.size.height?0:(image.size.height - image.size.width)/2;
    
    /** 2、把原图截取成一个正方形图片 */
    CGImageRef ref = [image CGImage];
    
    ref = CGImageCreateWithImageInRect(ref, CGRectMake(0, 0, wid, wid));
    
    image = [UIImage imageWithCGImage:ref];
    /**  */
    /** size 图形上下文的大小 */
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(wid, wid), false, 0);
    
    /** 3、添加剪切图片的区域 */
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, wid, wid)];
    [path addClip];
    
    /** 4、绘图 */
    [image drawInRect:CGRectMake(0,0, wid, wid)];
    
    NSLog(@"%@",NSStringFromCGRect(CGRectMake(x, y, wid, wid)));
    /** 5、获取图片 */
    image = UIGraphicsGetImageFromCurrentImageContext();
    /** 6、关闭图形上下文 */
    UIGraphicsEndImageContext();
    
    return image;
}
@end
