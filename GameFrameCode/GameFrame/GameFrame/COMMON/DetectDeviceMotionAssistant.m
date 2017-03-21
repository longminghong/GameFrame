//
//  DetectDeviceTileAssistant.m
//  GameTem
//
//  Created by longminghong on 17/3/16.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import "DetectDeviceMotionAssistant.h"

@implementation DetectDeviceMotionAssistant

@synthesize motionManager = motionManager_;

+ (instancetype _Nonnull)sharedInstance {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

#pragma mark -
#pragma mark property

- (CMMotionManager *)motionManager{
    
    if (nil == motionManager_) {
        motionManager_ = [[CMMotionManager alloc] init];
    }
    return motionManager_;
}

#pragma mark -
#pragma mark Detecting Device Tilt,检测设备倾斜

// demostration.

- (void)startDetectingDeviceTilt{
    
    NSOperationQueue* mainQueue = [NSOperationQueue mainQueue];
    
    [self.motionManager startDeviceMotionUpdatesToQueue:mainQueue
                                            withHandler:^(CMDeviceMotion *motion, NSError *error) {
                                                
                                                //                                                float roll = motion.attitude.roll;
                                                //                                                float rollDegrees = roll * 180 / M_PI;
                                                //
                                                //                                                float yaw = motion.attitude.yaw;
                                                //                                                float yawDegrees = yaw * 180 / M_PI;
                                                //
                                                //                                                float pitch = motion.attitude.pitch;
                                                //                                                float pitchDegrees = pitch * 180 / M_PI;
                                                
                                            }];
}

- (void)startDetectingDeviceTilt:(MHDeviceTiltHandle _Nonnull)handle{
    
    NSOperationQueue* mainQueue = [NSOperationQueue mainQueue];
    
    [self.motionManager startDeviceMotionUpdatesToQueue:mainQueue
                                            withHandler:^(CMDeviceMotion *motion, NSError *error) {
                                                
                                                float roll = motion.attitude.roll;
                                                float rollDegrees = roll * 180 / M_PI;
                                                
                                                float yaw = motion.attitude.yaw;
                                                float yawDegrees = yaw * 180 / M_PI;
                                                
                                                float pitch = motion.attitude.pitch;
                                                float pitchDegrees = pitch * 180 / M_PI;
                                                
                                                handle(rollDegrees,yawDegrees,pitchDegrees);
                                                
                                            }];
}

#pragma mark -
#pragma mark Getting the Compass Heading

// You want to know which direction the user is facing, relative to north.
// When you begin receiving device motion information, all attitude information is rela‐ tive to a reference frame. The reference frame is your “zero point” for orientation.
// By default, the zero point is set when you activate the device motion system

// demostration.
- (void)startGettingCompassHeading{
    /**
     CMAttitudeReferenceFrameXArbitraryZVertical
     Yaw is set to zero when the device motion system is turned on.
     CMAttitudeReferenceFrameXArbitraryCorrectedZVertical
     Yaw is set to zero when the device motion system is turned on, and the magneto‐ meter is used to keep this stable over time (i.e., the zero point won’t drift as much).
     CMAttitudeReferenceFrameXMagneticNorthZVertical
     The zero yaw point is magnetic north.
     CMAttitudeReferenceFrameXTrueNorthZVertical
     The zero yaw point is true north. The system needs to use the location system to figure this out.
     */
    NSOperationQueue* mainQueue = [NSOperationQueue mainQueue];
    
    [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:
     CMAttitudeReferenceFrameXTrueNorthZVertical toQueue:mainQueue
                                                        withHandler:^(CMDeviceMotion *motion,
                                                                      NSError *error) {
                                                            //                                                            float yaw = motion.attitude.yaw;
                                                            //                                                            float yawDegrees = yaw * 180 / M_PI;
                                                            
                                                        }];
}

- (void)startGettingCompassHeading:(MHDeviceCompassHandle _Nonnull)handle{
    
    NSOperationQueue* mainQueue = [NSOperationQueue mainQueue];
    
    [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:
     CMAttitudeReferenceFrameXTrueNorthZVertical toQueue:mainQueue
                                                        withHandler:^(CMDeviceMotion *motion, NSError *error) {
                                                            float yaw = motion.attitude.yaw;
                                                            float yawDegrees = yaw * 180 / M_PI;
                                                            handle(yawDegrees);
                                                        }];
}


#pragma mark -
#pragma mark Detecting Magnets

- (void)startDetectMagnets{
    
    [self.motionManager startMagnetometerUpdatesToQueue:[NSOperationQueue mainQueue]
                                            withHandler:^(CMMagnetometerData *magnetometerData,
                                                          NSError *error){
                                                
         CMMagneticField magneticField = magnetometerData.magneticField;
         NSString* xValue = [NSString stringWithFormat:@"%.2f", magneticField.x];
         NSString* yValue = [NSString stringWithFormat:@"%.2f", magneticField.y];
         NSString* zValue = [NSString stringWithFormat:@"%.2f", magneticField.z];
         double average = (magneticField.x + magneticField.y + magneticField.z) / 3.0;
         NSString* averageValue = [NSString stringWithFormat:@"%.2f", average];
         
         NSLog(@"Magnetic field:\nAverage: %@\tX: %@\tY: %@\tZ: %@",
               averageValue, xValue, yValue, zValue);
     }];
}

- (void)startDetectMagnetsWithHandle:(MHDeviceMagnetsHandle _Nonnull)handle{
    
    [self.motionManager startMagnetometerUpdatesToQueue:[NSOperationQueue mainQueue]
                                            withHandler:^(CMMagnetometerData *magnetometerData,
                                                          NSError *error){
                                                
         CMMagneticField magneticField = magnetometerData.magneticField;
         
         double average = (magneticField.x + magneticField.y + magneticField.z) / 3.0;
         
         handle (average, magneticField.x, magneticField.y, magneticField.z);
     }];
}


@end
