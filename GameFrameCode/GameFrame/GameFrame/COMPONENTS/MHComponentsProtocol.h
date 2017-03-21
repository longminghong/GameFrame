//
//  MHComponentsProtocol.h
//  GameFrame
//
//  Created by longminghong on 17/3/21.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GameObject;

@protocol MHComponentsProtocol <NSObject>

@property (weak) GameObject *gameObject;
@end
