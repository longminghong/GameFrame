//
//  SoundAssitant.h
//  GameTem
//
//  Created by longminghong on 17/3/16.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundAssitant : NSObject



- (void)playSound:(NSString *_Nonnull)resourceName extension:(NSString *_Nonnull)extension;
- (void)play;
- (void)pause;
- (void)stop;

#pragma mark -
#pragma mark sound pool

+ (NSMutableArray * _Nonnull) players ;
+ (AVAudioPlayer *_Nonnull) playerWithURL:(NSURL* _Nonnull)url;

- (void)fadePlayer:(AVAudioPlayer *_Nonnull)player fromVolume:(float)startVolume toVolume:(float)endVolume overTime:(float)time;

#pragma mark -
#pragma mark Recording Sound.
//You can find out if another application is currently playing audio
- (BOOL)isOtherAudioPlaying;

#pragma mark -
#pragma mark Recording Sound.

- (void)prepareToRecord;
- (void)startRecord;
- (void)stopRecord;
@end
