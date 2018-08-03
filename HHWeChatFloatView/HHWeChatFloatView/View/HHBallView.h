//
//  HHBallView.h
//  HHWeChatFloatView
//
//  Created by Mac on 2018/8/3.
//  Copyright © 2018年 Now. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHBallView : UIView

@property(nonatomic, strong)UIImageView *imgView;
@property(nonatomic, strong)CAShapeLayer *shapeLayer;

- (void)startAnimationForView:(UIView *)view fromRect:(CGRect)fromRect toRect:(CGRect)toRect;


@end
