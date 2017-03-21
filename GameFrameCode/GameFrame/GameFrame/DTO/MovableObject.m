//
//  MovableObject.m
//  GameTem
//
//  Created by longminghong on 17/3/15.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import "MovableObject.h"

@implementation MovableObject

- (void)die {
    
    if (_onDeathBlock!= nil) {
    
        self.onDeathBlock();
    }
}

- (void)hit {
    
    if (_onHitBlock!= nil) {
        
        self.onHitBlock();
    }
}

@end
