//
//  NibAssistant.m
//  GameTem
//
//  Created by longminghong on 17/3/16.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import "NibAssistant.h"

@implementation NibAssistant

+ (UIView * _Nullable)fetchViewObjectWithNib:(NSString * _Nonnull)nibName{
    
    UIView *resultView = nil;
    
    UINib* nib = [UINib nibWithNibName:nibName bundle:nil];
    
    NSArray* nibObjects = [nib instantiateWithOwner:self options:nil];
    
    resultView = [nibObjects firstObject];
    
    return resultView;
}

@end
