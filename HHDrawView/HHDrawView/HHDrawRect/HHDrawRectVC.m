//
//  HHDrawRectVC.m
//  HHDrawRectDemo
//
//  Created by LXH on 2017/6/23.
//  Copyright © 2017年 HHLM. All rights reserved.
//

#import "HHDrawRectVC.h"
#import "HHLDrawRectView.h"
#import "HHDrawAllView.h"
@interface HHDrawRectVC ()
{
    HHLDrawRectView *view;
}
@property (nonatomic, strong) HHDrawAllView *allView;
@end

@implementation HHDrawRectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    
    if (self.type == 6) {
        [self.view addSubview:self.allView];
    }else{
        view = [[HHLDrawRectView alloc] initWithFrame:self.view.bounds];;
        view.drawType = self.type;
        [self.view addSubview:view];
    }
}

- (HHDrawAllView *)allView {
    if (!_allView) {
        _allView = [[HHDrawAllView alloc] initWithFrame:self.view.bounds];
        _allView.backgroundColor = [UIColor whiteColor];
        
        _allView.layer.borderWidth = 2;
        _allView.layer.cornerRadius = 5;
        
        //设置文本的阴影色彩和透明度。
        _allView.layer.shadowColor = [UIColor redColor].CGColor;
        
        //设置阴影的倾斜角度。
        _allView.layer.shadowOffset = CGSizeMake(0.9f, 0.9f);
        _allView.layer.shadowOpacity = 0.5f;
        
        CGFloat colors[] = {0.5,0,0.4,1};
        CGColorSpaceRef ref = CGColorSpaceCreateDeviceRGB();
        CGColorRef color = CGColorCreate(ref, colors);
        _allView.layer.borderColor = color;
        
    }return _allView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [view.layer removeAllAnimations];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 1, 0)];
    
    animation.duration = 1.0f;
    
    animation.cumulative = YES;
    
    animation.repeatCount = INT_MAX;
    
    if (self.type == 6) {
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 0, 0)];
        [self.allView.layer addAnimation:animation forKey:@"animation"];
    }else{
        [view.layer addAnimation:animation forKey:@"animation"];
    }
    
}
@end
