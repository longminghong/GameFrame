//
//  LocationAssistant.h
//  GameTem
//
//  Created by longminghong on 17/3/16.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>

#define CT_LOCATION_TILE
#define CT_LOCATION_REGION
#define CT_LOCATION_SPEED
#define CT_LOCATION_STREET

typedef void(^MHLocationSpeedHandle)(float kPH,float mPH);
typedef void(^MHLocationGeoCodeFromAddressHandle)(float latitude,float longitude);
typedef void(^MHLocationAddressFromGeoCodeHandle)(NSString *address);

@interface LocationAssistant : NSObject<CLLocationManagerDelegate> {
    
    CLLocationManager* locationManager_;
    
    CLLocation* location;
    
    CLCircularRegion* regionToMonitor;
    
    CLGeocoder *geocoder_;
    
    CMMotionManager *motionManager_;
}

@property (nonatomic,strong) CLLocationManager* locationManager;
@property (nonatomic,strong) CLGeocoder *geocoder;
@property (nonatomic,strong) CMMotionManager *motionManager;

@property (copy) MHLocationSpeedHandle speedHandle;
//@property (copy) MHLocationGeoCodeFromAddressHandle geoCodeFromAddressHandle;

- (void)startUpdateLocation;


- (void)startMonitorWithCenter:(CLLocationCoordinate2D)coordinate radius:(double)radius identifier:(NSString *)identifier;
- (void)startMonitorWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude  radius:(double)radius identifier:(NSString *)identifier;


- (float)distanceFromLocation:(CLLocation *)distanceLocation;
- (float)distanceFromLocations:(float)latitude longitude:(float)longitude;


- (void)fetchGeocoderFromAddress:(NSString *)addressString handle:(MHLocationGeoCodeFromAddressHandle)handle;
- (void)fetchAddressFromGeocodeLocation:(CLLocation *)geocodeLocation handle:(MHLocationAddressFromGeoCodeHandle)handle;


@end
