//
//  GameObject.m
//  GameTem
//
//  Created by longminghong on 17/3/15.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import "GameObject.h"
#import "Component.h"

@interface GameObject()

- (void) update:(float)deltaTime;

@end

@implementation GameObject{

    NSMutableSet* _components;
}
@synthesize components = _components;
@synthesize timer = timer_;

- (dispatch_source_t)timer{

    if (nil == timer_) {
        
        dispatch_queue_t queue = dispatch_get_main_queue();
       
        // Create a dispatch source, and make it into a timer that goes off every second
        
        timer_ = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        
        dispatch_source_set_timer(timer_, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0);
    }
    return timer_;
}

- (id)init {
    self = [super init];
    if (self) {
        _components = [NSMutableSet set];
    }
    return self;
}

- (void)addComponent:(id<MHComponentsProtocol> _Nonnull)component {
    
    [_components addObject:component];
    component.gameObject = self;
}

- (void)removeComponent:(id<MHComponentsProtocol> _Nonnull)component {
    
    [_components removeObject:component];
    component.gameObject = nil;
}

- (void)update:(float)deltaTime {
    
    for (Component* component in _components) {
        [component update:deltaTime];
    }
}

- (id)componentWithType:(Class)componentType {
    // Helper function that just returns the first component with a given type
    return [[self componentsWithType:componentType] firstObject];
}

- (NSArray*)componentsWithType:(Class)componentType {
    // Return nil if the class isn't actually a type of component if ([componentType isSubclassOfClass:[Component class]] == NO)
    return nil;
    // Work out which components match the component type, and return them all
    return [[_components objectsPassingTest:^BOOL(id obj, BOOL *stop) { return [obj isKindOfClass:componentType];
    }] allObjects];
}

#pragma mark -
#pragma mark delay operations.

- (void)delay:(NSTimeInterval)timeInterval Operation:(SEL)operation{
    
    double timeToWait = timeInterval;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW,
                                              (int64_t)(timeToWait * NSEC_PER_SEC));
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_after(delayTime, queue, ^(void){
        
        // Time's up. Kaboom.
        
    });
}

#pragma mark -
#pragma mark saving state.

- (id) initWithCoder:(NSCoder*)coder {
    // note: not [super initWithCoder:coder]!
    self = [super init];
    if (self) {
        self.objectName = [coder decodeObjectForKey:@"name"];
        self.hitPoints = [coder decodeIntForKey:@"hitpoints"];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder*) coder {
    
    [coder encodeObject:self.objectName forKey:@"name"];
    [coder encodeInt:self.hitPoints forKey:@"hitpoints"];
}

#pragma mark -
#pragma mark timer actions.

- (void)timerStart{
    
    // When the timer goes off, heal the player
    dispatch_source_set_event_handler(self.timer, ^{
//        GivePlayerHitPoints();
    });
}

- (void)timerPaused{

    // Dispatch sources start out paused, so start the timer by resuming it
}

- (void)timerResume{

    // Dispatch sources start out paused, so start the timer by resuming it
    dispatch_resume(self.timer);
}

- (void)timerCancel{

    self.timer = nil;
    timer_ = nil;
}

@end
