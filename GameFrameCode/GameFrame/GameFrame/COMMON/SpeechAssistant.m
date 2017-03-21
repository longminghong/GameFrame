//
//  SpeechAssistant.m
//  GameTem
//
//  Created by longminghong on 17/3/17.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import "SpeechAssistant.h"
#import <AVFoundation/AVFoundation.h>

@interface SpeechAssistant(){

    AVSpeechSynthesizer *speechSynthesizer_;
}
@property (nonatomic,strong) AVSpeechSynthesizer* speechSynthesizer;
@end

@implementation SpeechAssistant
@synthesize speechSynthesizer = speechSynthesizer_;


#pragma mark -
#pragma mark property.

- (AVSpeechSynthesizer *)speechSynthesizer{

    if (nil == speechSynthesizer_) {
        speechSynthesizer_ = [[AVSpeechSynthesizer alloc] init];
    }
    return speechSynthesizer_;
}

#pragma mark -
#pragma mark speech.

- (void)speechSentence:(NSString *_Nonnull)sentence{

    AVSpeechUtterance* utterance = [AVSpeechUtterance
                                    speechUtteranceWithString:sentence];
    
    [self.speechSynthesizer speakUtterance:utterance];
    
    // Stop speaking immediately
    [self speechPause];
    
    // Once you’ve paused speaking, you can resume it at any time:
    [self speechContinue];
}

- (void)speechPause{

    [self.speechSynthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

- (void)speechContinue{

    [self.speechSynthesizer continueSpeaking];
}

@end
