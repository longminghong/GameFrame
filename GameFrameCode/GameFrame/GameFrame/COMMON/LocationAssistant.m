//
//  LocationAssistant.m
//  GameTem
//
//  Created by longminghong on 17/3/16.
//  Copyright © 2017年 longminghong. All rights reserved.
//


/**
 P 116
 */

#import "LocationAssistant.h"
#import <UIKit/UIKit.h>

@implementation LocationAssistant

@synthesize locationManager = locationManager_;
@synthesize geocoder = geocoder_;
@synthesize motionManager = motionManager_;

- (CMMotionManager *)motionManager{
    
    if (nil == motionManager_) {
        
        motionManager_ =  [[CMMotionManager alloc] init];
    }
    return motionManager_;
}

- (CLGeocoder *)geocoder{
    
    if (nil == geocoder_) {
        geocoder_ = [[CLGeocoder alloc] init];
    }
    return geocoder_;
}

- (CLLocationManager *)locationManager{
    
    if (nil == locationManager_) {
        
        locationManager_ = [[CLLocationManager alloc] init];
        locationManager_.delegate = self;
    }
    return locationManager_;
}

- (void)startUpdateLocation{
    
    [self.locationManager startUpdatingLocation];
    
    // when you call this function.
    // you will reach CLLocationManagerDelegate call back.
}

- (void)startMonitorWithCenter:(CLLocationCoordinate2D)coordinate radius:(double)radius identifier:(NSString *)identifier{
    
    CLRegion* region = [[CLCircularRegion alloc] initWithCenter:coordinate
                                                         radius:radius identifier:identifier];
//    if (nil == regionToMonitor) {
//        
//        regionToMonitor = [[CLCircularRegion alloc]
//                           initWithCenter:coordinate
//                           radius:radius
//                           identifier:identifier];
//    }
    
    [self.locationManager startMonitoringForRegion:region];
}
- (void)startMonitorWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude  radius:(double)radius identifier:(NSString *)identifier{
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
    [self startMonitorWithCenter:coordinate radius:radius identifier:identifier];
}


#pragma mark -
#pragma mark  Receiving Notifications When the User Changes Location

//  regions are always circular
// You can only register 20 regions at a time
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    
    //    self.locationErrorLabel.hidden = YES;
    
    location = [locations lastObject];
    
    float latitude = location.coordinate.latitude;
    
    float longitude = location.coordinate.longitude;
    
    
    regionToMonitor = [[CLCircularRegion alloc]
                       initWithCenter:location.coordinate radius:20
                       identifier:@"StartingPoint"];
    
    [manager startMonitoringForRegion:regionToMonitor];
    
#pragma mark -
#pragma mark Calculating the User’s Speed
    
    if (location.speed > 0) {
        
        float kPH = location.speed * 3.6;
        
        float mPH = location.speed * 2.236936;
        
        if (self.speedHandle) {
            
            self.speedHandle (kPH,mPH);
        }
    }
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    //    self.locationErrorLabel.hidden = NO;
    
}

#pragma mark -
#pragma mark distance from location.
/**
 distanceFromLocation:
 want to calculate how far away the user is from a location.
 */
- (float)distanceFromLocation:(CLLocation *)distanceLocation{
    
    CLLocation* userLocation = self.locationManager.location;  // get the user's location from CoreLocation
    
    float distance = [userLocation distanceFromLocation:distanceLocation];
    
    return distance;
}

- (float)distanceFromLocations:(float)latitude longitude:(float)longitude{
    
    CLLocation* otherLocation = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    
    float distance = [self distanceFromLocation:otherLocation];
    
    return distance;
}

#pragma mark -
#pragma mark

- (void) locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"Entering region!");
}
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"Exiting region!");
}

#pragma mark -
#pragma mark address assitant.

- (void)fetchGeocoderFromAddress:(NSString *)addressString handle:(MHLocationGeoCodeFromAddressHandle)handle{
    
    [self.geocoder geocodeAddressString:addressString
                      completionHandler:^(NSArray*placemarks, NSError *error) {
                          
                          CLPlacemark* placemark = [placemarks lastObject];
                          
                          float latitude = placemark.location.coordinate.latitude;
                          float longitude = placemark.location.coordinate.longitude;
                          
                          if (handle) {
                              
                              handle(latitude,longitude);
                          }
                      }];
}

- (void)fetchAddressFromGeocodeLocation:(CLLocation *)geocodeLocation handle:(MHLocationAddressFromGeoCodeHandle)handle{
    
    [self.geocoder reverseGeocodeLocation:geocodeLocation
                        completionHandler:^(NSArray
                                            *placemarks, NSError *error) {
                            NSString *addressString = [placemarks lastObject];
                            if (handle) {
                                
                                handle(addressString);
                            }
                        }
     ];
}
#pragma mark -
#pragma mark Using the Device as a Steering Wheel.

- (void)startDeviceMotionDetect{
    
    [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                            withHandler:^(CMDeviceMotion *motion, NSError *error)
     {
         // Maximum steering left is -50 degrees,
         // maximum steering right is 50 degrees
         float maximumSteerAngle = 50;
         // When in landscape,
         float rotationAngle = motion.attitude.pitch * 180.0f / M_PI; // -1.0 = hard left, 1.0 = hard right
         float steering = 0.0;
         
         UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
         
         if (orientation == UIInterfaceOrientationLandscapeLeft) {
             steering = rotationAngle / -maximumSteerAngle;
         } else if (orientation == UIInterfaceOrientationLandscapeRight) { steering = rotationAngle / maximumSteerAngle;
         }
         // Limit the steering to between -1.0 and 1.0
         steering = fminf(steering, 1.0);
         steering = fmaxf(steering, -1.0);
         NSLog(@"Steering: %.2f", steering);
     }];
}


- (void)activeLocationChangesNotification{
    
    
}
@end
