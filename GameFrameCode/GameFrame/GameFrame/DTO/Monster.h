//
//  Monster.h
//  GameTem
//
//  Created by longminghong on 17/3/15.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import "MovableObject.h"

@interface Monster : MovableObject


/**
 hitPoints:num of times it can be hit without dying
 */
@property (assign) float hitPoints;


/**
 targetObject:try to kill this object
 */
@property (weak) GameObject *targetObject;

@end
