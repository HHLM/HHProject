//
//  HHBarChartView.m
//  HHDrawView
//
//  Created by Mac on 2018/6/8.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHBarChartView.h"

@implementation HHBarChartView


- (void)drawRect:(CGRect)rect {
    [self addCharView];
    [self addRoundCharView];
}

- (void)addCharView {
    NSArray *array = @[@20,@15,@60,@100,@40,@75,@50,@90];
    NSInteger count = array.count;
    CGFloat maxHeight = self.height/2 - 100;
    CGFloat wid = self.width/(2*count + 1);
    CGFloat height = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0;i < array.count; i ++) {
        x = wid + (2*wid)*i;
        height = [array[i] floatValue]/100 * maxHeight;
        y = self.height/2 - height;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, wid, height)];
        [[UIColor randomColor] set];
        [path fill];
    }
    
}

- (void)addRoundCharView {
    
    CGPoint center = CGPointMake(self.width/2, self.height/4*3);
    CGFloat starA = 0;
    CGFloat endA = 0;
    
    /** 每个扇形所占比例  第一个扇形结束时候的角度是下一个扇形的开始角度  */
    
    NSArray *dataArray = @[@20,@15,@60,@100,@40,@75,@50,@90];

    CGFloat sum = [[dataArray valueForKeyPath:@"@sum.floatValue"] floatValue];  //总和
    CGFloat mid = [[dataArray valueForKeyPath:@"@avg.floatValue"] floatValue];  //平均数
    CGFloat max = [[dataArray valueForKeyPath:@"@max.floatValue"] floatValue];  //最大值
    CGFloat min = [[dataArray valueForKeyPath:@"@min.floatValue"] floatValue];  //最小值
    
    NSLog(@"%f-%f-%f",mid,min,max);
    
    for (NSNumber *number in dataArray) {
        
        //计算每个扇形占比 的角度
        CGFloat addA = [number floatValue]/sum * M_PI*2;
        /** 计算结束角度 */
        endA = starA + addA;
        /** 描绘路径 */
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:100
                                                        startAngle:starA
                                                          endAngle:endA
                                                         clockwise:YES];
        /** 和中心点连线 */
        [path addLineToPoint:center];
        /** 设置颜色 */
        [[UIColor randomColor] set];
        /** 填充颜色 会会默认封闭空间 */
        [path fill];
        /** 下一个扇形的起始角度 是当前扇形的结束角度 */
        starA = endA;
        
    }
}


@end
