//
//  SoundAssitant.m
//  GameTem
//
//  Created by longminghong on 17/3/16.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import "SoundAssitant.h"


/**
 • AAC (8 to 320 Kbps)
 • Protected AAC (from the iTunes Store)
 • HE-AAC
 • MP3 (8 to 320 Kbps)
 • MP3 VBR
 • Audible (formats 2, 3, 4, Audible Enhanced Audio, AAX, and AAX+)
 • Apple Lossless
 • AIFF
 • WAV
 
 best to go with AAC, MP3, AIFF, or WAV.
 
 */

@interface SoundAssitant(){
    
    // you need to keep a strong reference to it
    // If you have multiple sounds that you want to play at the same time, you need to keep references to each (or use an NSArray to contain them all).
    // use a dedicated sound engine instead of managing each player yourself.
    AVAudioPlayer *audioPlayer_;
    AVAudioRecorder *audioRecorder;
}
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;
@end


NSMutableArray* _players = nil;

@implementation SoundAssitant{
    
    
}

@synthesize audioPlayer = audioPlayer_;

#pragma mark -
#pragma mark property


- (void)playSound:(NSString *_Nonnull)resourceName extension:(NSString *_Nonnull)extension{
    
    NSError* error = nil;
    
    
    NSURL* soundFileURL = [[NSBundle mainBundle] URLForResource:resourceName
                                                  withExtension:extension];
    
    audioPlayer_ = nil;
    self.audioPlayer = nil;
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
    
    
    if (error != nil) {
        
        NSLog(@"Failed to load the sound: %@", [error localizedDescription]);
    }
    [self.audioPlayer prepareToPlay];
    
    //    player.numberOfLoops = 0; //play one time and then stop:
    
    //    player.numberOfLoops = 1; //play twice and then stop
    
    //    player.numberOfLoops = -1; // play forever, until manually stopped
    
    [self.audioPlayer play];
}

- (void)play{
    
    [self.audioPlayer play];
}

- (void)pause{
    
    [self.audioPlayer pause];
}

- (void)stop{
    
    [self.audioPlayer stop];
}

#pragma mark -
#pragma mark sound pool

// use multiple audio players, but reuse players when possible

+ (NSMutableArray*) players {
    if (_players == nil)
        _players = [[NSMutableArray alloc] init];
    return _players;
}

+ (AVAudioPlayer *)playerWithURL:(NSURL *)url {
    
    NSMutableArray* availablePlayers = [[self players] mutableCopy];
    // Try and find a player that can be reused and is not playing
    [availablePlayers filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(AVAudioPlayer* evaluatedObject, NSDictionary *bindings) {
        
        return evaluatedObject.playing == NO && [evaluatedObject.url isEqual:url];
    }]];
    // If we found one, return it
    if (availablePlayers.count > 0) {
        
        return [availablePlayers firstObject];
    }
    // Didn't find one? Create a new one
    NSError* error = nil;
    AVAudioPlayer* newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                                      error:&error];
    if (newPlayer == nil) {
        NSLog(@"Couldn't load %@: %@", url, error);
        return nil;
    }
    [[self players] addObject:newPlayer];
    
    return newPlayer;
}

#pragma mark -
#pragma mark Cross-Fading Between Tracks

//[self fadePlayer:self.audioPlayer fromVolume:0.0 toVolume:1.0 overTime:1.0];
//[self fadePlayer:self.audioPlayer fromVolume:1.0 toVolume:0.0 overTime:1.0];
- (void) fadePlayer:(AVAudioPlayer*)player fromVolume:(float)startVolume toVolume:(float)endVolume overTime:(float)time {
    
    // Update the volume every 1/100 of a second
    float fadeSteps = time * 100.0;
    
    self.audioPlayer.volume = startVolume;
    
    for (int step = 0; step < fadeSteps; step++) {
        
        double delayInSeconds = step * (time / fadeSteps);
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            float fraction = ((float)step / fadeSteps);
            
            self.audioPlayer.volume = startVolume + (endVolume - startVolume) * fraction;});
    }
}


- (BOOL)isOtherAudioPlaying{
    
    BOOL otherAudioPlaying = NO;
    
    AVAudioSession* session = [AVAudioSession sharedInstance];
    
    if (session.otherAudioPlaying) {
        // Another application is playing audio. Don't play any sound that might // conflict with music, such as your own background music.
        
        otherAudioPlaying = YES;
    }else{
        // No other app is playing audio - crank the tunes!
        
        otherAudioPlaying = NO;
    }
    
    return otherAudioPlaying;
}

#pragma mark -
#pragma mark Recording Sound.

- (void)prepareToRecord{
    
    NSURL* documentsURL = [[[NSFileManager defaultManager]
                            URLsForDirectory:NSDocumentDirectory
                            inDomains:NSUserDomainMask] lastObject];
    
    NSURL* destinationURL = [documentsURL
                             URLByAppendingPathComponent:@"RecordedSound.wav"];
    
//    NSURL* destinationURL = [self audioRecordingURL];
    
    NSError* error;
    
    audioRecorder = [[AVAudioRecorder alloc] initWithURL:destinationURL
                                                settings:nil error:&error];
    if (error != nil) {
        NSLog(@"Couldn't create a recorder: %@", [error localizedDescription]);
    }
    [audioRecorder prepareToRecord];
}

- (void)startRecord{

    [audioRecorder record];
}

- (void)stopRecord{

    [audioRecorder stop];
}


@end
