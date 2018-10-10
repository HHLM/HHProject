//
//  ViewController.m
//  HHClock
//
//  Created by Mac on 2018/8/2.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "HHClockView.h"
/** 角度转弧度 */
#define kAngleToRadian(a) ((a) * M_PI)/180.0)
/** 分钟一分钟转动角度6° */
#define kMintueRadian 6
/** 秒针一秒转动角度 6° */
#define kSecondRadian 6
/** 时针一小时转动角度 30°*/
#define kHourRadian 30
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *clockView;
@property (nonatomic, strong) CALayer *hourLayer;
@property (nonatomic, strong) CALayer *mintueLayer;
@property (nonatomic, strong) CALayer *secondLayer;
@property (nonatomic, strong) HHClockView *clock;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _clock = [[HHClockView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.view addSubview:_clock];
    self.clockView.layer.contents = (id)[UIImage imageNamed:@"clock"].CGImage;
    [self.clockView.layer addSublayer:[self hourLayer]];
    [self.clockView.layer addSublayer:[self minuterLayer]];
    [self.clockView.layer addSublayer:[self secondLayer]];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addTimeChanage) userInfo:nil repeats:YES];
    [self addTimeChanage];
}

- (void)addTimeChanage {
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calender components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:[NSDate date]];
    NSInteger hour = comp.hour;
    NSInteger minute = comp.minute;
    NSInteger second = comp.second;
    
    /** 计算秒转旋转的角度 */
    CGFloat secondAngle = second/60.0*M_PI*2;
    /** 分针旋转角度 */
    CGFloat mintueAngle = minute/60.0*M_PI*2;
    /** 时针旋转角度
     时针的角度+分针转动带动的角度
     */
    CGFloat hourAngle = 1/12.0*M_PI*2*(hour + minute/60.0);
    
    self.secondLayer.transform = CATransform3DMakeRotation(secondAngle, 0, 0, 1);
    self.mintueLayer.transform = CATransform3DMakeRotation(mintueAngle, 0, 0, 1);
    self.hourLayer.transform = CATransform3DMakeRotation(hourAngle, 0, 0, 1);
    
    
    
}

 #pragma mark -- CALayer
- (CALayer *)hourLayer {
    if (!_hourLayer) {
        _hourLayer = [self creatLayer];
        _hourLayer.bounds = CGRectMake(0, 0, 4, CGRectGetWidth(self.clockView.frame)/2-20);
        _hourLayer.backgroundColor = [UIColor blackColor].CGColor;
    }
    return _hourLayer;
}
- (CALayer *)minuterLayer {
    if (!_mintueLayer) {
        _mintueLayer = [self creatLayer];
        _mintueLayer.bounds = CGRectMake(0, 0, 3, CGRectGetWidth(self.clockView.frame)/2-10);
        _mintueLayer.backgroundColor = [UIColor blackColor].CGColor;
    }
    return _mintueLayer;
}
- (CALayer *)secondLayer {
    if (!_secondLayer) {
        _secondLayer = [self creatLayer];
        _secondLayer.bounds = CGRectMake(0, 0, 2, CGRectGetWidth(self.clockView.frame)/2-6);
        _secondLayer.backgroundColor = [UIColor redColor].CGColor;
    }return _secondLayer;
}
- (CALayer *)creatLayer {
    CALayer *layer = [CALayer layer];
    layer.position = CGPointMake(CGRectGetWidth(self.clockView.frame)/2, CGRectGetHeight(self.clockView.frame)/2);
    layer.anchorPoint = CGPointMake(0.5, 0.9);
    return layer;
    
}

@end
