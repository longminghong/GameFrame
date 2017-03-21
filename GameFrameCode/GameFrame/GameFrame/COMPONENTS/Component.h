//
//  Component.h
//  GameTem
//
//  Created by longminghong on 17/3/15.
//  Copyright © 2017年 longminghong. All rights reserved.
//

// 如果有更多的属性需要添加,或人物属性,行为要添加,可以自己扩展这个类。
// 每个 gameobject都有自己的一个list的component

#import <Foundation/Foundation.h>

@class GameObject;

@interface Component : NSObject

@property (weak) GameObject *gameObject;

- (void)update:(float)deltaTime;

@end
