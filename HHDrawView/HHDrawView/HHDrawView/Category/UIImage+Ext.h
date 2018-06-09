//
//  UIImage+Ext.h
//  HHDrawView
//
//  Created by Mac on 2018/6/9.
//  Copyright © 2018年 Now. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Ext)
#pragma -- 截取一个圆形图片
/**
  - 截成圆形图片
 @return image
 */
+ (UIImage *)clipRoundImage:(UIImage *)image;

/**
  - 是否截取图片中间的部分 主要针对于长方形的图片
 @param image 图片
 @param center 是否是图片中心区域
 @return image
 */
+ (UIImage *)clipRoundImage:(UIImage *)image center:(BOOL)center;

/**
 - 否截取图片中间的部分 相对于中心的位置  scale 范围 [-1,1]
 @param image 图片
 @param scacle 相对于中心的位置 scale [-1,1] ; < 0 偏向左或偏上; > 0 偏向下或者偏右
 @return image
 */
+ (UIImage *)clipRoundImage:(UIImage *)image scacle:(CGFloat)scacle;

#pragma -- 截取一个带圆环的圆形图片

/**
 切一个带圆环的图片 默认圆环宽度是 2

 @param image 图片
 @param cirqueColor 圆环颜色
 @return image
 */
+ (UIImage *)clipCirqueImage:(UIImage *)image cirqueColor:(UIColor *)cirqueColor;

/**
 切一个带圆环的图片
 @param image 图片
 @param cirqueColor 圆环颜色
 @param border 圆环宽度
 @return image
 */
+ (UIImage *)clipCirqueImage:(UIImage *)image cirqueColor:(UIColor *)cirqueColor border:(CGFloat)border;

#pragma mark -- 截屏

/**
 截取某个控件图形
 @param view 需要被截取的控件
 @return image
 */
+ (UIImage *)screenShotView:(UIView *)view;

/**
 截取某个控件图形
 @param view 需要被截取的控件
 @param contentRect 截取需要的内容区域大小
 @return image
 */
+ (UIImage *)screenShotView:(UIView *)view contentRect:(CGRect)contentRect;

/**
 截取scrollView全部内容
 @param scrollView UIScrollView的类
 @return image
 */
+ (UIImage *)screenShotScrollView:(UIScrollView *)scrollView;

@end
