//
//  HHDrawRectView.h
//  HHDrawRectDemo
//
//  Created by LXH on 2017/6/23.
//  Copyright © 2017年 HHLM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , HHDrawType) {
    
    HHDrawTextType = 0,     //文字
    HHDrawLineType = 1,     //线条
    HHDrawSquareType = 2,   //矩形
    HHDrawRoundType = 3,    //圆形
    HHDrawDashLinType = 4,  //虚线
    HHDrawImageType = 5,    //图片
    
};

@interface HHLDrawRectView : UIView

//划线类型
@property (nonatomic, assign) HHDrawType drawType;

@end
