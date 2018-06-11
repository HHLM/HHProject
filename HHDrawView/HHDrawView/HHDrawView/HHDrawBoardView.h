//
//  HHDrawBoardView.h
//  HHDrawView
//
//  Created by Mac on 2018/6/10.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHBaseView.h"

@interface HHDrawBoardView : HHBaseView
/** 线条宽度 */
@property (nonatomic, assign) CGFloat lineWidth;
/** 线条颜色 */
@property (nonatomic, strong) UIColor *lineColor;
/** 设置的图片 */
@property (nonatomic, strong) UIImage *image;

/** 清除 */
- (void)clearPath;

/** 撤销上一个 */
- (void)repealPath;

/** 保存图片 */
- (void)savePhoto;
@end
