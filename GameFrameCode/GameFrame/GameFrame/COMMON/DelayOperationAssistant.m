//
//  DelayOperationAssistant.m
//  GameTem
//
//  Created by longminghong on 17/3/15.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import "DelayOperationAssistant.h"

@implementation DelayOperationAssistant


- (void)delayInterval:(NSTimeInterval)interval operation:(NSInvocation *)invocation{

    if (nil == invocation) {
        return;
    }
    
    double timeToWait = interval;
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW,
                                              (int64_t)(timeToWait * NSEC_PER_SEC));
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_after(delayTime, queue, ^(void){
        
        [invocation invoke];
    });

}
@end
