//
//  TimerAssistant.m
//  GameTem
//
//  Created by longminghong on 17/3/15.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import "TimerAssistant.h"

@interface TimerAssistant()


@property (strong) NSDate* gameStartDate;

@end

@implementation TimerAssistant

- (void)gameStart{
    
    self.gameStartDate = [NSDate date];
}

- (NSTimeInterval)timeIntervalSinceGameStart{
    
    NSDate *now = [NSDate date];
    
    NSTimeInterval timeSinceGameStart =
    [self.gameStartDate timeIntervalSinceDate:now];
    
    return timeSinceGameStart;
}

- (float)minutesElapsed{
    
    NSTimeInterval timeElapsed = [self timeIntervalSinceGameStart];
    
    float minutes = timeElapsed / 60.0; // 60 seconds per minute
    
    return minutes;
}

- (float)hoursElapsed{
    NSTimeInterval timeElapsed = [self timeIntervalSinceGameStart];
    float hours = timeElapsed / 3600.0; // 3600 seconds per hour
    return hours;
}

- (float)secondsElapsed{
    NSTimeInterval timeElapsed = [self timeIntervalSinceGameStart];
    float seconds = fmodf(timeElapsed, 60.0); // get the remainder
    return seconds;
}

@end
