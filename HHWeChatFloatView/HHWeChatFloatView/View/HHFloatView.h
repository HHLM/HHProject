//
//  HHFloatView.h
//  HHWeChatFloatView
//
//  Created by Mac on 2018/8/3.
//  Copyright © 2018年 Now. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHFloatView;
@protocol HHFloatViewDelegate <NSObject>
@optional
- (void)hh_floatViewClicked:(HHFloatView *)floatView;
- (void)hh_floatViewTouchsBegan:(HHFloatView *)floatView;
- (void)hh_floatViewTouchsMoved:(HHFloatView *)floatView;
- (void)hh_floatViewTouchsEnded:(HHFloatView *)floatView;
@end

@interface HHFloatView : UIView
@property (nonatomic, copy)NSString *imageName;
@property (nonatomic, assign) id <HHFloatViewDelegate> delegate;
@end
