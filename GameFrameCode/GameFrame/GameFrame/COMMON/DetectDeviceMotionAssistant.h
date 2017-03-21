//
//  DetectDeviceTileAssistant.h
//  GameTem
//
//  Created by longminghong on 17/3/16.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

//检测设备倾斜，贴近磁铁的距离，罗盘

typedef void(^MHDeviceTiltHandle)(float rollDegrees,float yawDegrees,float pitchDegrees);
typedef void(^MHDeviceCompassHandle)(float yawDegrees);
typedef void(^MHDeviceMagnetsHandle)(float averageValue,float xValue,float yValue,float zValue);

@interface DetectDeviceMotionAssistant : NSObject{

#pragma mark -
#pragma mark detecting device tilt
    
    CMMotionManager* motionManager_;
}

@property (nonatomic,strong) CMMotionManager* _Nonnull motionManager;

+ (instancetype _Nonnull)sharedInstance ;

- (void)startDetectingDeviceTilt:(MHDeviceTiltHandle _Nonnull)handle;
- (void)startGettingCompassHeading:(MHDeviceCompassHandle _Nonnull)handle;
- (void)startDetectMagnetsWithHandle:(MHDeviceMagnetsHandle _Nonnull)handle;
@end
