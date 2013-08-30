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
#import <Accounts/Accounts.h>


@interface ViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *heartSpinner;
@property (strong, nonatomic) IBOutlet UILabel *theDistanceLabel;
@property (strong, nonatomic) NSString * username;
@property (strong, nonatomic) NSString * theDistance;
@property (strong, nonatomic) CLLocation *currentLoc;
@property CLLocationCoordinate2D * retrievedMateLocation;
@property (nonatomic, strong) NSString * strLatitude;
@property (nonatomic, strong) NSString * strLongitude;
@property float retrievedMateLat;
@property float retrievedMateLong;
@property (nonatomic) BOOL headingDidStartUpdating;
@property (nonatomic) ACAccountStore *accountStore;
- (IBAction)updateMyLocation:(id)sender;
- (id)reverseTransformedValue:(id)value;
- (IBAction)tweetRetrieve:(id)sender;

@end

CLLocationManager *locationManager;
