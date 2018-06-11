//
//  HHDrawTopView.h
//  HHDrawView
//
//  Created by Mac on 2018/6/11.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHBaseView.h"

typedef void(^DrawTopViewBlock)(UIImage *image);

@interface HHDrawTopView : HHBaseView

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) DrawTopViewBlock block;

@end
