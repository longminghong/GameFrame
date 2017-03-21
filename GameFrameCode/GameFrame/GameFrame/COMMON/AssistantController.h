//
//  AssistantController.h
//  GameTem
//
//  Created by longminghong on 17/3/16.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AssistantController : NSObject

@property (strong) NSURL* baseURL;

typedef void (^AssetsLoadingBlock)(NSData* loadedData);
typedef void (^AssetsLoadingCompleteBlock)(void);

+ (instancetype)sharedInstance ;

- (NSURL*) urlForAsset:(NSString*) assetName;

- (void) loadAsset:(NSString* )assetName withCompletion:(AssetsLoadingBlock)
completionBlock;

- (void) waitForResourcesToLoad:(AssetsLoadingCompleteBlock)completionBlock;

@end
