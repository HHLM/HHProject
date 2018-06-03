//
//  HHBaseTableViewCell.m
//  HHMasonryDemo
//
//  Created by Mac on 2018/6/3.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHBaseTableViewCell.h"

@implementation HHBaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.originXSeparatorLine = 20;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect
{
    if (self.originXSeparatorLine >= 0) {
        for (CALayer *layer in self.layer.sublayers) {
            if ([layer.name isEqualToString:@"separator"]) {
                [layer removeFromSuperlayer];
                break;
            }
        }
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        if (!self.heightSeparatorLine) {
            self.heightSeparatorLine = 0.5;
        }
        CGPathRef path = CGPathCreateWithRect(CGRectMake(self.originXSeparatorLine, rect.size.height-self.heightSeparatorLine, [UIScreen mainScreen].bounds.size.width, self.heightSeparatorLine), NULL);
        [shapeLayer setPath:path];
        CGPathRelease(path);
        if (!self.colorSeparatorLine) {
            self.colorSeparatorLine = [UIColor redColor];
        }
        [shapeLayer setFillColor: self.colorSeparatorLine.CGColor];
        [shapeLayer setName:@"separator"];
        [self.layer addSublayer:shapeLayer];
    }else {
        for (CALayer *layer in self.layer.sublayers) {
            if ([layer.name isEqualToString: @"separator"]) {
                [layer removeFromSuperlayer];
            }
        }
    }
}

/*!重画
 */
- (void)setOriginXSeparatorLine:(int)originXSeparatorLine
{
    _originXSeparatorLine = originXSeparatorLine;
    [self setNeedsDisplay];
}

- (void)setColorSeparatorLine:(UIColor *)colorSeparatorLine
{
    _colorSeparatorLine = colorSeparatorLine;
    [self setNeedsLayout];
}

/*!设置数据
 */
- (void)setData:(id )data delegate:(id)delegate
{
    
}

+ (CGFloat)heightWithData:(id)data;
{
    return 0;
}
@end
