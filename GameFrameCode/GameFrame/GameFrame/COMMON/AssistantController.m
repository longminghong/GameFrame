//
//  AssistantController.m
//  GameTem
//
//  Created by longminghong on 17/3/16.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import "AssistantController.h"

@implementation AssistantController{
    
    double lastFrameTime;
    
    dispatch_queue_t _loadingQueue;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (id)init {
    self = [super init]; if (self) {
        // Find assets inside the "Assets" folder, which is copied in
        self.baseURL = [[[NSBundle mainBundle] resourceURL]
                        URLByAppendingPathComponent:@"Assets" isDirectory:YES];
        // Create the loading queue
        _loadingQueue = dispatch_queue_create("com.YourGame.LoadingQueue",
                                              DISPATCH_QUEUE_SERIAL);
    }
    return self; }
- (NSURL *)urlForAsset:(NSString *)assetName {
    // Determine where to find the asset
    return [self.baseURL URLByAppendingPathComponent:assetName];
}

- (void)loadAsset:(NSString *)assetName withCompletion:(AssetsLoadingBlock) completionBlock {
    // Load the asset in the background; when it's done, give the loaded // data to the completionBlock
    NSURL* urlToLoad = [self urlForAsset:assetName];
    dispatch_queue_t mainQueue = dispatch_get_main_queue(); dispatch_async(_loadingQueue, ^{
        NSData* loadedData = [NSData dataWithContentsOfURL:urlToLoad];
        dispatch_sync(mainQueue, ^{
            completionBlock(loadedData);
        }); });
}
- (void)waitForResourcesToLoad:(AssetsLoadingCompleteBlock)completionBlock {
    // Run the block on the main queue, after all of the load requests that // have been queued up are complete
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    dispatch_async(_loadingQueue, ^{
        
        dispatch_sync(mainQueue, completionBlock);
    });
}



- (void)update:(double)currentTime {
    
    //    double currentTime = [NSDate timeIntervalSinceReferenceDate];
    
    double deltaTime = currentTime - lastFrameTime;
    
    // Move at 3 units per second
    float movementSpeed = 3;
    //    [someObject moveAtSpeed:movementSpeed * deltaTime];
    
    lastFrameTime = currentTime;
}
@end
