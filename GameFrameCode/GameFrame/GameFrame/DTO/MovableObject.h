//
//  MovableObject.h
//  GameTem
//
//  Created by longminghong on 17/3/15.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import "GameObject.h"


typedef void(^CallBackBlock)(void);

typedef void(^DeathCallBackBlock)(void);
typedef void(^HitCallBackBlock)(void);

@interface MovableObject : GameObject

@property (copy) DeathCallBackBlock onDeathBlock;
@property (copy) HitCallBackBlock onHitBlock;

- (void)die;
- (void)hit;

@end
