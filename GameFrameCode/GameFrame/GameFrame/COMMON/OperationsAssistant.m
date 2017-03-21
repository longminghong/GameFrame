//
//  OperationsAssistant.m
//  GameTem
//
//  Created by longminghong on 17/3/15.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import "OperationsAssistant.h"

const NSInteger OperationsAssistant_MaxOperationsCount = 5;

@interface OperationsAssistant(){
    
    NSOperationQueue* concurrentQueue_;
    
    NSOperationQueue* mainQueue_;
    
    NSInteger maxOperationCount;
}

@property(nonatomic,strong) NSOperationQueue* concurrentQueue;

@property(nonatomic,strong) NSOperationQueue* mainQueue;

@end

@implementation OperationsAssistant

@synthesize concurrentQueue = concurrentQueue_;
@synthesize mainQueue = mainQueue_;

#pragma mark -
#pragma mark property

- (NSOperationQueue *)concurrentQueue{
    
    if (nil == concurrentQueue_) {
        
        concurrentQueue_ = [[NSOperationQueue alloc] init];
        
        if (0 == maxOperationCount) {
            maxOperationCount = OperationsAssistant_MaxOperationsCount;
        }
        
        concurrentQueue_.maxConcurrentOperationCount = maxOperationCount;
    }
    return concurrentQueue_;
}


- (NSOperationQueue *)mainQueue{
    
    if (nil == mainQueue_) {
        
        mainQueue_ = [NSOperationQueue mainQueue];
    }
    return mainQueue_;
}


#pragma mark -
#pragma mark init

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        maxOperationCount = 0;
    }
    return self;
}
#pragma mark -
#pragma mark demostration.

- (void)addBackgroundOperationToBlock{
    
    [self.concurrentQueue addOperationWithBlock:^{
        //        UploadHighScores();
    }];
}

- (void)addPriorityOperationToBlock{
    
    [self.mainQueue addOperationWithBlock:^{
        //        ProcessPlayerInput();
    }];
}

- (void)addBackgroundOperationToBlockUpdateAfterFinish{
    
    NSOperationQueue* backgroundQueue = [[NSOperationQueue alloc] init];
    
    [backgroundQueue addOperationWithBlock:^{
        
        // do something
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            NSLog(@"This is run on the main queue"); }];
    }];
}

#pragma mark -
#pragma mark set operation count.

- (void)setMaxOprationCount:(NSInteger)count{
    
    if (0 > count) {
        
        maxOperationCount = count;
        
        self.concurrentQueue.maxConcurrentOperationCount = maxOperationCount;
    }
}

#pragma mark -
#pragma mark add operation.

- (void)addBackgroundOperationTarget:(id)target selector:(SEL)selector{
    
    @try {
        [self.concurrentQueue addOperationWithBlock:^{
            
            if (target) {
                if ([target respondsToSelector:selector]) {
                    [target selector];
                }
            }
        }];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

- (void)addBackgroundOperationWithInvocation:(NSInvocation *)invocation{
    
    @try {
        if (invocation) {
            [self.concurrentQueue addOperationWithBlock:^{
                
                [invocation invoke];
            }];
        }
    } @catch (NSException *exception) {
        
#if defined(DEBUG) && DEBUG_NSLOG_CATCH_EXCEPTION
        
        NSLog(@"%s,%s,%@",__FILE__,__FUNCTION__,exception);
#endif
    } @finally {
        
    }
}


- (void)addPriorityOperationTarget:(id)target selector:(SEL)selector{
    
    @try {
        [self.mainQueue addOperationWithBlock:^{
            
            if (target) {
                if ([target respondsToSelector:selector]) {
                    [target selector];
                }
            }
        }];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

- (void)addPriorityOperationWithInvocation:(NSInvocation *)invocation{
    
    @try {
        if (invocation) {
            
            [self.mainQueue addOperationWithBlock:^{
                
                [invocation invoke];
            }];
        }
    } @catch (NSException *exception) {
        
#if defined(DEBUG) && DEBUG_NSLOG_CATCH_EXCEPTION
        
        NSLog(@"%s,%s,%@",__FILE__,__FUNCTION__,exception);
#endif
    } @finally {
        
    }
}


- (void)addBackgroundOperation:(NSInvocation *)invocation updateAfterFinish:(NSInvocation *)finishInvocation{
    
    NSOperationQueue* backgroundQueue = [[NSOperationQueue alloc] init];
    
    [backgroundQueue addOperationWithBlock:^{
        
        // do something
        [invocation invoke];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [finishInvocation invoke];
        }];
    }];
}

#pragma mark -
#pragma mark Depend Operations

- (void)dependentOperations{
    
    NSBlockOperation* firstOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"First operation");
    }];
    NSBlockOperation* secondOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"Second operation (depends on third operation and first operation)");
    }];
    NSBlockOperation* thirdOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"Third operation");
    }];
    [secondOperation addDependency:thirdOperation];
    
    [secondOperation addDependency:firstOperation];
    
    [[NSOperationQueue mainQueue] addOperations:@[firstOperation, secondOperation,
                                                  thirdOperation] waitUntilFinished:NO];
}

- (void)dependentOperations:(NSArray *)array{

    
}

#pragma mark -
#pragma mark Delay Operations

- (void)delayOperation{
    
    // Place a bomb, but make it explode in 10 seconds
    //    PlaceBomb();
    
    double timeToWait = 10.0;
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW,
                                              (int64_t)(timeToWait * NSEC_PER_SEC));
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_after(delayTime, queue, ^(void){
        
        // Time's up. Kaboom.
        //  ExplodeBomb();
    });
}

@end
