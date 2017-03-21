//
//  NibAssistant.h
//  GameTem
//
//  Created by longminghong on 17/3/16.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NibAssistant : NSObject

+ (UIView * _Nullable)fetchViewObjectWithNib:( NSString * _Nonnull )nibName;
@end
