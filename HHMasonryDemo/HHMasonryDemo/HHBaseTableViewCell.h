//
//  HHBaseTableViewCell.h
//  HHMasonryDemo
//
//  Created by Mac on 2018/6/3.
//  Copyright © 2018年 Now. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHBaseTableViewCell : UITableViewCell

//  >=0 has separator; <0 no separator
@property (nonatomic, assign) int originXSeparatorLine;

@property (nonatomic, assign) CGFloat heightSeparatorLine;

@property (nonatomic, strong) UIColor *colorSeparatorLine;

/** 设置数据 */
- (void)setData:(id )data delegate:(id)delegate;

/** 根据数据计算cell的高度 */
+ (CGFloat)heightWithData:(id)data;


@end
