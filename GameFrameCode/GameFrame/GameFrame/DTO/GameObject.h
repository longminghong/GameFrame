//
//  GameObject.h
//  GameTem
//
//  Created by longminghong on 17/3/15.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObjectProtocol.h"
#import "MHComponentsProtocol.h"


@interface GameObject : NSObject<NSCoding,GameObjectProtocol>{

    dispatch_source_t timer_;
}
@property (nonatomic,strong) dispatch_source_t timer;
@property (strong) NSSet *components;
@property (nonatomic,assign) BOOL shouldPause;

@property (nonatomic,strong) NSString * objectName;
@property (nonatomic,assign) int hitPoints;

- (void)update:(float)deltaTime;

- (void)addComponent:(id<MHComponentsProtocol> _Nonnull)component;
- (void)removeComponent:(id<MHComponentsProtocol> _Nonnull)component;

- (id<MHComponentsProtocol> _Nonnull)componentWithType:(Class)componentType;
- (NSArray* _Nullable)componentsWithType:(Class)componentType;

@end
