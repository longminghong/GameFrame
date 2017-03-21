//
//  AssetsAssistant.m
//  GameTem
//
//  Created by longminghong on 17/3/15.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import "AssetsAssistant.h"

/**
 
 DISPATCH_QUEUE_PRIORITY_HIGH
    Blocks on this queue will be scheduled to run before those on all other lower-priority queues.
 
 DISPATCH_QUEUE_PRIORITY_DEFAULT
    Blocks on this queue will be scheduled to run after those on high-priority queues, but before blocks on low-priority queues.
 
 DISPATCH_QUEUE_PRIORITY_LOW
    Blocks on this queue will be scheduled to run after those on all other higher-priority queues.
 
 DISPATCH_QUEUE_PRIORITY_BACKGROUND
    The same as PRIORITY_LOW, but the system will dedicate even fewer resources to it.
 
 */

@implementation AssetsAssistant


- (void)loadingAssets{

    
}

- (void)loadingImagesAssets:(NSArray *)imagesToLoad{
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(                                                                                                                   DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    for (NSString* imageFileName in imagesToLoad) {
        
        dispatch_group_async(group, backgroundQueue, ^{
            
            // Load the file
        });
    }
    
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_group_notify(group, mainQueue, ^{
        // This block run immediately after all blocks in the dispatch group have finished running
        // All images are done loading at this point
        
        
    });
}

@end
