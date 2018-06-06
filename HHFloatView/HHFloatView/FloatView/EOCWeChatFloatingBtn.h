//
//  EOCWeChatFloatingBtn.h
//  微信浮窗一  公开课
//
//  Created by 八点钟学院 on 2018/6/5.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 1、浮窗的展示，浮窗按钮 和 右下侧四分之一圆的实现和布局
 2、浮窗的拖动效果：上下拖动到屏幕边缘； 左右拖动的过程中，根据离左右两边的距离，回弹到最近的一边；浮窗点击能跳转页面，拖动过程中，右下方四分之源的动画能展示出来；浮窗按钮进入到右下侧四分之圆的地方，浮窗消失；
 3、点击浮窗，进入浮窗页面的展开动画效果
 4、叉掉浮窗页面的收缩效果
 5、浮窗页面手势侧滑，超过1/2页面松开，收缩动画效果
 */


@interface EOCWeChatFloatingBtn : UIView

+ (void)show;

@end
