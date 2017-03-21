//
//  ArtificialIntelligence.m
//  GameTem
//
//  Created by longminghong on 17/3/17.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import "ArtificialIntelligence.h"
#import <SpriteKit/SpriteKit.h>

@implementation ArtificialIntelligence

#pragma mark -
#pragma mark Making an Object Move Toward a Position

+ (void)AICaculateDirectionForObject:(id)object towardPosition:(GLKVector2)position{
    
    // Determine the direction to this position
    GLKVector2 myPosition ; // the location where we are right now
    GLKVector2 targetPosition ; // the location where we want to be
    float movementSpeed = 0; // how fast we want to move toward this target
    GLKVector2 offset = GLKVector2Subtract(targetPosition, myPosition);
    // Reduce this vector to be the same length as our movement speed
    offset = GLKVector2Normalize(offset);
    //    offset = GLKVector2MultiplyScalar(offset, self.movementSpeed * deltaTime);
    //    // Add this to our current position
    //    GLKVector2 newPosition = self.position;
    //    newPosition.x += offset.x;
    //    newPosition.y += offset.y;
    //    self.position = newPosition;
}

#pragma mark -
#pragma mark make an object follow a path from point to point, turning to face the next destination

// When you have a path, keep a list of points. Move to the target (see Recipe 11.1). When you reach it, remove the first item from the list; then move to the new first item in the list

- (void) moveToPath:(NSArray*)pathPoints {
    if (pathPoints.count == 0) return;
    
    //    CGPoint nextPoint = [[pathPoints firstObject] CGPointValue];
    //
    //    GLKVector2 currentPosition = GLKVector2Make(self.position.x, self.position.y);
    //
    //    GLKVector2 nextPointVector =
    //    GLKVector2Make(nextPoint.x, nextPoint.y);
    //
    //    GLKVector2 toTarget = GLKVector2Subtract(nextPointVector, currentPosition); float distance = GLKVector2Length(toTarget);
    //
    //    float speed = 50;
    //
    //    float time = distance / speed;
    //
    //    SKAction* moveAction = [SKAction moveTo:nextPoint duration:time];
    //
    //    SKAction* nextPointAction = [SKAction runBlock:^{
    //
    //        NSMutableArray* nextPoints = [NSMutableArray arrayWithArray:pathPoints];
    //        [nextPoints removeObjectAtIndex:0];
    //
    //        [self moveToPath:nextPoints];
    //    }];
    //
    //    [self runAction:[SKAction sequence:@[moveAction, nextPointAction]]];
}

#pragma mark -
#pragma mark Making an Object Intercept a Moving Target

// You want an object to move toward another object, intercepting it.

- (void)blockWay{
    
    /**
     GLKVector2 myPosition = ... // our current position
     GLKVector2 targetPosition = ... // the current position of the target float myMovementSpeed = ... // how fast we're moving
     float targetMovementSpeed = ... // how fast it's moving
     GLKVector2 toTarget = GLKVector2Subtract(targetPosition, myPosition); float lookAheadTime = GLKVector2Length(toTarget) /
     (myMovementSpeed + targetMovementSpeed);
     CGPoint destination = target.position;
     destination.x += targetMovementSpeed * lookAheadTime;
     destination.y += targetMovementSpeed * lookAheadTime;
     [self moveToPosition:destination deltaTime:deltaTime];
     */
}

#pragma mark -
#pragma mark Making an Object Flee When It’s in Trouble

- (void)flee{
    /**
     GLKVector2 myPosition = ... // our current position
     GLKVector2 targetPosition = ... // the current position of the target float myMovementSpeed = ... // how fast we're moving
     GLKVector2 offset = GLKVector2Subtract(targetPosition, myPosition); // Reduce this vector to be the same length as our movement speed
     offset = GLKVector2Normalize(offset);
     // Note the minus sign - we're multiplying by the inverse of
     // our movement speed, which means we're moving away from it
     offset = GLKVector2MultiplyScalar(offset, -myMovementSpeed * deltaTime);
     // Add this to our current position
     CGPoint newPosition = self.position;
     newPosition.x += offset.x;
     newPosition.y += offset.y;
     self.position = newPosition;
     */
}

#pragma mark -
#pragma mark Making an Object Decide on a Target


- (void)targetOn{
    
    /**
     
     
     */
}

#pragma mark -
#pragma mark Making an Object Steer Toward a Point

- (void)steerToward{
    
    /**
     
     // Work out the vector from our position to the target
     GLKVector2 myPosition = ... // our position
     GLKVector2 targetPosition = ... // target position
     float turningSpeed = ... // the maximum amount of turning we can do, in radians
     // per second
     GLKVector2 toTarget = GLKVector2Subtract(targetPosition, myPosition); GLKVector2 forwardVector = ... // the forward vector: rotate [0,1] by whatever
     // direction we're currently facing
     // Get the angle needed to turn toward this position
     float angle = GLKVector2DotProduct(toTarget, forwardVector);
     angle /= acos(GLKVector2Length(toTarget) * GLKVector2Length(forwardVector));
     
     // Clamp the angle to our turning speed
     angle = fminf(angle, turningSpeed);
     angle = fmaxf(angle, -turningSpeed);
     // Apply the rotation
     self.rotation += angle * deltaTime;
     
     */
}

#pragma mark -
#pragma mark Making an Object Know Where to Take Cover

- (void)takeCover{
    /**
     CGPoint myPosition = ... // current position
     CGPoint coverPosition = ... // potential cover position
     SKPhysicsWorld* physicsWorld = self.scene.physicsWorld;
     __block BOOL canUseCover = NO;
     [physicsWorld enumerateBodiesAlongRayStart:myPosition end:coverPosition
     
     usingBlock:^(SKPhysicsBody *body, CGPoint point, CGVector normal, BOOL *stop) { if (body == self.physicsBody)
     return;
     // We hit something, so there's something between us // and the cover point. Good!
     canUseCover = YES;
     // Stop looping
     *stop = YES;
     }];
     if (canUseCover) { 
     // Take cover
     }
     */
}

#pragma mark -
#pragma mark Calculating a Path for an Object to Take

- (void)obstacleAvoidingPathCalculate{

    
}

#pragma mark -
#pragma mark Determining if an Object Can See Another Object

- (void)find{

    
}

@end
