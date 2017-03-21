//
//  SpeechAssistant.h
//  GameTem
//
//  Created by longminghong on 17/3/17.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpeechAssistant : NSObject

- (void)speechSentence:(NSString *_Nonnull)sentence;
- (void)speechPause;
- (void)speechContinue;

@end
