//
//  ViewController.h
//  orphan
//
//  Created by MasterRyuX on 6/30/13.
//  Copyright (c) 2013 MasterRyuX. All rights reserved.
//location logic on vc//
//artwork on storyboard//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "MateLocation.h"


@interface ViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *heartSpinner;
@property (strong, nonatomic) NSString * theDistance;
@property (strong, nonatomic) CLLocation *currentLoc;
@property (nonatomic, strong) NSString * strLatitude;
@property (nonatomic, strong) NSString * strLongitude;
@property (nonatomic) BOOL headingDidStartUpdating;

@end

CLLocationManager *locationManager;
