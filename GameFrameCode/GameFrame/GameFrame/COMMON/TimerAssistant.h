//
//  TimerAssistant.h
//  GameTem
//
//  Created by longminghong on 17/3/15.
//  Copyright © 2017年 longminghong. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////
////
//If you would like to caculate HOW LONG THIS GAME LAST, since this app open.
//call gameStart(). when this game is opened.
//
//如果你想知道这个游戏从启动到当前运行了多久,你可以在程序启动的时候调用gameStart().
//可以用
//timeIntervalSinceGameStart().的到总共消耗的时间
////
////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>

/**
    when you start your game, call gameStart().
 
    When you finish a game, call timeIntervalSinceGameStart(). to get the time it Elapsed.
 */

@interface TimerAssistant : NSObject

- (void)gameStart;

- (NSTimeInterval)timeIntervalSinceGameStart;

- (float)minutesElapsed;
- (float)hoursElapsed;
- (float)secondsElapsed;

@end
