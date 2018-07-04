//
//  UIControl+Ext.m
//  HHRuntime
//
//  Created by Mac on 2018/5/25.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "UIControl+Ext.h"
#import <objc/message.h>
#import <objc/runtime.h>

static const char *UIControl_eventInterval = "UIControl_eventInterval";
static const char *UIControl_ignoreEnvent = "UIControl_ignoreEnvent";

@implementation UIControl (Ext)
/**
 runtime 进行方法交换  重写新的方法
 */
+ (void)load {
    //swizzle
    // class_getInstanceMethod 获取对象方法
    // class_getClassMethod 获取类方法
    
    Method method1 = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method method2 = class_getInstanceMethod(self, @selector(new_sendAction:to:forEvent:));
    method_exchangeImplementations(method1, method2);
}
#pragma mark -- 通过runtime 重写get set方法
- (void)setEventInterval:(NSTimeInterval)eventInterval {
    objc_setAssociatedObject(self, UIControl_eventInterval, @(eventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)eventInterval {
    return [objc_getAssociatedObject(self, UIControl_eventInterval) doubleValue];
}

- (void)setIgnoreEvent:(BOOL)ignoreEvent {
    objc_setAssociatedObject(self, UIControl_ignoreEnvent, @(ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)ignoreEvent {
    return [objc_getAssociatedObject(self, UIControl_ignoreEnvent) boolValue];
}

//新方法
- (void)new_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (self.ignoreEvent)  return;
    if (self.eventInterval > 0) {
        //设置时间后  先设置为YES 点击么有反应
        self.ignoreEvent = YES;
        //一段时间后在改成NO 再次点击 就可以继续执行下面的方法
        [self performSelector:@selector(setIgnoreEvent:) withObject:@(NO) afterDelay:self.eventInterval];
    }
    //调用实现方法
    [self new_sendAction:action to:target forEvent:event];
}

@end
