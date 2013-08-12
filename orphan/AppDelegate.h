//
//  AppDelegate.h
//  orphan
//
//  Created by MasterRyuX on 6/30/13.
//  Copyright (c) 2013 MasterRyuX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MateLocation.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate, MKMapViewDelegate>

{
    NSArray *distanceSortedArray;
    float startingUserLocationFloatLat;
    float startingUserLocationFloatLong;
    NSString *latitudeWithCurrentCoordinates;
    NSString *longitudeWithCurrentCoordinates;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSString * strLatitude;
@property (nonatomic, strong) NSString * strLongitude;
@property (nonatomic, strong) CLLocationManager *ourLocationManager;
@property (nonatomic, strong) MateLocation * mateLocation;
//@property (nonatomic, strong)




@end
