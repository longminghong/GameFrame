//
//  PerlinNoise.h
//  GameTem
//
//  Created by longminghong on 17/3/21.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PerlinNoise : NSObject

// The shared noise object.
+ (instancetype) sharedInstance;

// Begins generating a UIImage filled with perlin noise,
// given a size, a persistence value, the number of
// octaves, the random seed to use, and a block to call
// when the image is done.

- (void) imageWithSize:(CGSize)size persistence:(float)persistence octaves:(int)octaves seed:(int) seed completion:(void (^)(UIImage* image)) completionBlock;

// Calculates Perlin noise at a position.
- (float) perlinNoiseAtPosition:(CGPoint)position persistence:(float)persistence octaves:(int)octaves seed:(int)seed;
@end
