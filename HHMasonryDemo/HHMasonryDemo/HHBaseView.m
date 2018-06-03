//
//  HHBaseView.m
//  HHMasonryDemo
//
//  Created by Mac on 2018/6/3.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHBaseView.h"

@implementation HHBaseView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        /** 使用Masonry注意：
         - 给view添加约束时，必须已经添加到其superview上面
         - 不需要设置view.translatesAutoresizingMaskIntoConstraints = NO;，masonry内部已经帮我设置过了
         - 手写布局时，合理使用约束，尽量约束冲突问题
         - 因为iOS中原点在左上角所以注意使用offset时注意right和bottom用负数
         */
        
        /** 告知页面需要更新，但是不会立刻开始更新。执行后会立刻调用layoutSubviews。 */
//        [self setNeedsLayout];
//        
//        /** 告知需要更新约束，但是不会立刻开始 */
//        [self setNeedsUpdateConstraints];
    }
    return self;
}


- (void)addd {
    [self setNeedsUpdateConstraints];
}

/** 告诉 UIKit使用 AutoLayout */
+ (BOOL)requiresConstraintBasedLayout {
    return true;
}

/**
 告知页面布局立刻更新。所以一般都会和setNeedsLayout一起使用。
 如果希望立刻生成新的frame需要调用此方法，利用这点一般布局动画可以在更新布局后直接使用这个方法让动画生效。
*/
- (void)layoutIfNeeded {
    NSLog(@"layoutIfNeeded");
}

/** 系统重写布局 */
- (void)layoutSubviews {
    NSLog(@"layoutSubviews");
}

/** 系统更新约束 */
- (void)updateConstraints {
   
    NSLog(@"updateConstraints");
    
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.center.equalTo(self.superview);
    }];
    
    
    [super updateConstraints];
}


/** 告知立刻更新约束 */
- (void)updateConstraintsIfNeeded {
     NSLog(@"updateConstraintsIfNeeded");
}


/**  1、 References

 你可以持有某个特定的约束，让其成为成员变量或者属性
 //设置为公共或私接口
 
 @property (nonatomic, strong) MASConstraint *topConstraint;
 
 // 添加约束
 
 [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
 
 self.topConstraint = make.top.equalTo(superview.mas_top).with.offset(padding.top);
 
 make.left.equalTo(superview.mas_left).with.offset(padding.left);
 
 }];
 
 //该约束移除
 [self.topConstraint uninstall];
 //重新设置value,最常用
 self.topConstraint.mas_equalTo(20);
 //该约束失效
 [self.topConstraint deactivate];
 //该约束生效
 [self.topConstraint activate];

 */


/**   2、 mas_updateConstraints
 
    mas_updateConstraints
 
 如果你只是想更新一下view对应的约束，可以使用 mas_updateConstraints 方法代替 mas_makeConstraints方法
 //这是苹果推荐的添加或者更新约束的地方
 
 // 在响应setNeedsUpdateConstraints方法时，这个方法会被调用多次
 
 // 此方法会被UIKit内部调用，或者在你触发约束更新时调用
 */


/**   3、 mas_remakeConstraints

    mas_updateConstraints只是去更新一些约束，然而有些时候修改一些约束值是没用的，
 这时候mas_remakeConstraints就可以派上用场了
 
    mas_remakeConstraints某些程度相似于mas_updateConstraints，
 但不同于mas_updateConstraints去更新约束值，他会移除之前的view的所有约束，然后再去添加约束
 
 */





@end
