//
//  GameStateAssistant.h
//  GameTem
//
//  Created by longminghong on 17/3/16.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObjectProtocol.h"

@interface GameStateAssistant : NSObject

@property (nonatomic,assign) BOOL paused;

+ (instancetype _Nonnull)sharedInstance;

- (NSData * _Nullable)archiveGameObject:(id<GameObjectProtocol>_Nonnull)object;

- (id<GameObjectProtocol>_Nullable)recoverArchiveGameObject:(NSData *_Nonnull)data;

- (BOOL)storeHighScore:(int)score playsName:(NSString *_Nonnull)name;

- (void)getHighScoreFromLocal;
@end
