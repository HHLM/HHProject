//
//  HHDrawTextView.m
//  HHDrawDemo
//
//  Created by Mac on 2018/6/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "HHDrawTextView.h"

@implementation HHDrawTextView

- (void)drawRect:(CGRect)rect {
    [self drawText1];
    [self drawText2];
    [self drawText3];
}
- (void)drawText3 {
    NSString *string = @"这篇文章我们来讲一下UITableView的cell自适应高度，以及遇到的问题的解决办法。在看文章之前希望你已经会UITableView的基本使用了。";
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];

    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle  alloc] init];
    /** 字体行间距 */
    style.lineSpacing = 2;
    /** 首行缩进 */
    style.firstLineHeadIndent = 10;
    /** 文本对其方式 */
    style.alignment = NSTextAlignmentLeft;
    /** 超过大小展示方式 */
//    style.lineBreakMode = NSLineBreakByTruncatingTail;
    /** 整体缩进 首行除外 */
    style.headIndent = 20;
    
    /** 显示宽度 */
//    style.tailIndent = 100;
    /** 段与段之间的间距 */
    style.paragraphSpacing = 6;
    /** 最低行高 */
    style.minimumLineHeight = 20;
    /** 最大行高 */
    style.maximumLineHeight = 30;
    
    /** 段首行空白空间 */
    style.paragraphSpacingBefore = 3.0f;
    /** 从左到右的书写方向（一共➡️三种） */
    style.baseWritingDirection = NSWritingDirectionLeftToRight;
    
//    style.lineHeightMultiple = 15;
    /** 连字属性 在iOS，唯一支持的值分别为0和1 */
    style.hyphenationFactor = 0;
    
    /** 设置段落风格 */
    attributes[NSParagraphStyleAttributeName] = style;
    /** 字体大小 */
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:24];
    /** 字体颜色 */
    attributes[NSForegroundColorAttributeName]  = [UIColor redColor];
    
    [string drawInRect:CGRectMake(20, 370, CGRectGetWidth(self.bounds) - 40, 300) withAttributes:attributes];
    
}

- (void)drawText2 {
    /** 在一定区域内 */
    NSString *string = @"这篇文章我们来讲一下UITableView的cell自适应高度，以及遇到的问题的解决办法。在看文章之前希望你已经会UITableView的基本使用了。";
    /**
     drawInRect ： 文字区域范围
     withAttributes：富文本格式
     */
    
    //阴影
    NSShadow *shadow = [[NSShadow alloc] init];
    /** 阴影偏移 */
    shadow.shadowOffset = CGSizeMake(5, 5);
    /** 阴影颜色 */
    shadow.shadowColor = [UIColor greenColor];
    /** 阴影半径 lur radius of the shadow in default user space units */
    shadow.shadowBlurRadius = 5;
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    //设置阴影
    attributes[NSShadowAttributeName] = shadow;
    /** 设置边线颜色  会修改掉设置字体的颜色*/
    attributes[NSStrokeColorAttributeName] = [UIColor cyanColor];
    /** 设置字体边线宽度 */
    attributes[NSStrokeWidthAttributeName] = @5.f;
    /** 字体大小 */
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:24];
    /** 字体颜色 */
    attributes[NSForegroundColorAttributeName]  = [UIColor redColor];
    /** 字体背景颜色 */
    attributes[NSBackgroundColorAttributeName] = [UIColor yellowColor];
    /** 字体间距 */
    attributes[NSKernAttributeName] = @2;
    /** 下划线宽度 */
    attributes[NSUnderlineStyleAttributeName] = @1;
    /** 下划线颜色 */
    attributes[NSUnderlineColorAttributeName] = [UIColor blueColor];
    /** 删除线宽度 */
    attributes[NSStrikethroughStyleAttributeName] = @1;
    /** 删除线颜色 */
    attributes[NSStrikethroughColorAttributeName] = [UIColor redColor];
    /** 连体字符 */
    attributes[NSLigatureAttributeName] = @0;
    /** 字体的行间距 */
    attributes[NSBaselineOffsetAttributeName] = @10;
    /** 设置字体倾斜 */
    attributes[NSObliquenessAttributeName] = @0.5;
    /** 书写方向 */
    attributes[NSWritingDirectionAttributeName] = NSWritingDirectionLeftToRight;
    
    /** 设置段落 */
    
    NSParagraphStyle *style = [NSParagraphStyle defaultParagraphStyle];
    
    attributes[NSParagraphStyleAttributeName] =  style;
    /** 字体排版反向 */
    attributes[NSVerticalGlyphFormAttributeName] = @1;
    
    [string drawInRect:CGRectMake(20, 60, CGRectGetWidth(self.bounds) - 40, 300) withAttributes:attributes];
}

- (void)drawText1 {
    /** 这种不会换行 */
    NSString *string = @"这篇文章我们来讲一下UITableView的cell自适应高度，以及遇到的问题的解决办法。在看文章之前希望你已经会UITableView的基本使用了。";
    [string drawAtPoint:CGPointMake(20, 20) withAttributes:nil];
}

/**
 // NSFontAttributeName                设置字体属性，默认值：字体：Helvetica(Neue) 字号：12
 // NSForegroundColorAttributeNam      设置字体颜色，取值为 UIColor对象，默认值为黑色
 // NSBackgroundColorAttributeName     设置字体所在区域背景颜色，取值为 UIColor对象，默认值为nil, 透明色
 // NSLigatureAttributeName            设置连体属性，取值为NSNumber 对象(整数)，0 表示没有连体字符，1 表示使用默认的连体字符
 // NSKernAttributeName                设定字符间距，取值为 NSNumber 对象（整数），正值间距加宽，负值间距变窄
 // NSStrikethroughStyleAttributeName  设置删除线，取值为 NSNumber 对象（整数）
 // NSStrikethroughColorAttributeName  设置删除线颜色，取值为 UIColor 对象，默认值为黑色
 // NSUnderlineStyleAttributeName      设置下划线，取值为 NSNumber 对象（整数），枚举常量 NSUnderlineStyle中的值，与删除线类似
 // NSUnderlineColorAttributeName      设置下划线颜色，取值为 UIColor 对象，默认值为黑色
 // NSStrokeWidthAttributeName         设置笔画宽度，取值为 NSNumber 对象（整数），负值填充效果，正值中空效果
 // NSStrokeColorAttributeName         填充部分颜色，不是字体颜色，取值为 UIColor 对象
 // NSShadowAttributeName              设置阴影属性，取值为 NSShadow 对象
 // NSTextEffectAttributeName          设置文本特殊效果，取值为 NSString 对象，目前只有图版印刷效果可用：
 // NSBaselineOffsetAttributeName      设置基线偏移值，取值为 NSNumber （float）,正值上偏，负值下偏
 // NSObliquenessAttributeName         设置字形倾斜度，取值为 NSNumber （float）,正值右倾，负值左倾
 // NSExpansionAttributeName           设置文本横向拉伸属性，取值为 NSNumber （float）,正值横向拉伸文本，负值横向压缩文本
 // NSWritingDirectionAttributeName    设置文字书写方向，从左向右书写或者从右向左书写
 // NSVerticalGlyphFormAttributeName   设置文字排版方向，取值为 NSNumber 对象(整数)，0 表示横排文本，1 表示竖排文本
 // NSLinkAttributeName                设置链接属性，点击后调用浏览器打开指定URL地址
 // NSAttachmentAttributeName          设置文本附件,取值为NSTextAttachment对象,常用于文字图片混排
 // NSParagraphStyleAttributeName      设置文本段落排版格式，取值为 NSParagraphStyle 对象
 
 */

@end
