//
//  HHDrawBoardView.m
//  HHDrawView
//
//  Created by Mac on 2018/6/10.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHDrawBoardView.h"
#import "HHBezierPath.h"
#import "HHDrawTopView.h"
@interface HHDrawBoardView()
@property (nonatomic, strong) HHDrawTopView  *topView;
@property (nonatomic, strong) NSMutableArray *paths;
@property (nonatomic, strong) HHBezierPath *path;
@end

@implementation HHDrawBoardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }return self;
}

- (HHDrawTopView *)topView {
    if (!_topView) {
        _topView = [[HHDrawTopView alloc] initWithFrame:self.bounds];
    }return _topView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
}

- (NSMutableArray *)paths {
    if (!_paths) {
        _paths = [NSMutableArray array];
    }return _paths;
}

/** 清除 */
- (void)clearPath{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

/** 撤销上一个 */
- (void)repealPath {
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}
/** 设置图片 */
- (void)setImage:(UIImage *)image {
   
    [self addSubview:self.topView];
    self.topView.image = image;
    __weak HHDrawBoardView *weakSelf = self;
    
    [self.topView setBlock:^(UIImage *image) {
        [weakSelf.paths addObject:image];
        [weakSelf setNeedsDisplay];
    }];
    
    
}
/** 设置线条颜色 */
- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
}
/** 设置线条宽度 */
- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}

/** 橡皮擦 */
- (void)erasurePath {
    _lineColor = self.backgroundColor;
}

/** 保存图片 */
- (void)savePhoto {
    /** 1、开始位图图形上下文 */
    UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0);
    
    /** 2、获取图形上下文 */
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    /** 3、渲染到图形上下文 */
    [self.layer renderInContext:ctx];
    
    /** 4、获取图片 */
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    /** 5、关闭图形上下文 */
    UIGraphicsEndImageContext();
    
    /** 6、保存图片到相册 */
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
/** 保存到相册回调的方法 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        NSLog(@"图片保存成功");
    }
}


- (void)setUp {
    _lineWidth = 1.f;
    _lineColor = [UIColor blackColor];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    CGPoint statPoint = [pan locationInView:self];
    if (pan.state == UIGestureRecognizerStateBegan) {
        _path = [[HHBezierPath alloc] init];
        [_path moveToPoint:statPoint];
        _path.color = _lineColor;
        _path.lineWidth = _lineWidth;
        
        [self.paths addObject:_path];
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        /** 连线 */
        [_path addLineToPoint:statPoint];
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    for (id objc in self.paths) {
        if ([objc isKindOfClass:[UIImage class]]) {
            [(UIImage *)objc drawInRect:self.bounds];
        }else {
            HHBezierPath *path = (HHBezierPath *)objc;
            [path.color set];
            [path stroke];
        }
    }
}


@end
