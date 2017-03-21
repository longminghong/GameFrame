//
//  GameStateAssistant.m
//  GameTem
//
//  Created by longminghong on 17/3/16.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import "GameStateAssistant.h"


@implementation GameStateAssistant

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

#pragma mark -
#pragma mark state store.

- (NSData *)archiveGameObject:(id<GameObjectProtocol>_Nonnull)object{

    // an object that conforms to NSCoder
    NSData* archivedData = [NSKeyedArchiver archivedDataWithRootObject:object];
    
    return archivedData;
}


#pragma mark -
#pragma mark state recover.

- (id<GameObjectProtocol>)recoverArchiveGameObject:(NSData *_Nonnull)data{
    
    id<GameObjectProtocol> object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return object;
}

#pragma mark -
#pragma mark Storing High Scores In Local.

- (BOOL)storeHighScore:(int)score playsName:(NSString *_Nonnull)name{
    
    BOOL storeSuccess = NO;
    
    NSDictionary* scoreDictionary = @{@"score": [NSString stringWithFormat:@"%d",score], @"date":[NSDate date],
                                      @"playerName": name};
    NSArray* highScores = @[scoreDictionary];
    
    NSURL* documentsURL = [[[NSFileManager defaultManager]
                            URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]
                           lastObject];
    
    NSURL* highScoreURL = [documentsURL URLByAppendingPathComponent:
                           @"HighScores.plist"];
    
    storeSuccess = [highScores writeToURL:highScoreURL atomically:YES];
    
    return storeSuccess;
}

- (void)getHighScoreFromLocal{
    
    NSError* error = nil;
    
    NSArray *highScores;
    NSURL *highScoreURL;
    
    highScores = [NSArray arrayWithContentsOfURL:highScoreURL];
    
    if (highScores == nil) {
    
        NSLog(@"Error loading high scores: %@", error);
    }else{
        
        NSLog(@"Loaded scores: %@", highScores);
    }

}


@end
