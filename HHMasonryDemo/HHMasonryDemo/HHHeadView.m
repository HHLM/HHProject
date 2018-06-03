//
//  HHHeadView.m
//  HHMasonryDemo
//
//  Created by Mac on 2018/6/3.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHHeadView.h"

@implementation HHHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.headLable = [UILabel new];
        self.headLable.backgroundColor = [UIColor greenColor];
        self.headLable.numberOfLines = 0;
        self.headLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.headLable];
        
        [self.headLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            //make.left.top.mas_equalTo(20);
            //make.right.bottom.mas_equalTo(-20);
            
            //相对于superviewde上左下右边距分别为20，20，20，20
            // make.edges.equalTo(self.headView).insets(UIEdgeInsetsMake(20, 20, 20, 20));
            
            //make.top.left.and.right.equalTo(self.headView);
            //make.bottom.equalTo(@(-30));
            
            //中心在headView的中心
            //make.center.equalTo(self.headView);
            //水平方向中心相对向左偏移25，竖直方向中心向下偏移25
            make.center.equalTo(self).centerOffset(CGPointMake(-25, 25));
            //相对于self.headView宽度小100，高度小100
            make.size.equalTo(self).sizeOffset(CGSizeMake(-100, -100));
        }];
        
    }
    return self;
}

- (void)layoutIfNeeded {
    
}

- (void)setTitleString:(NSString *)titleString {
    _titleString = titleString;
    self.headLable.text = _titleString;
}

@end
