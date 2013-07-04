//
//  AppDelegate.m
//  orphan
//
//  Created by MasterRyuX on 6/30/13.
//  Copyright (c) 2013 MasterRyuX. All rights reserved.
//

//location logic on appdelegate//


#import "AppDelegate.h"


@implementation AppDelegate

{


//parse variables
    
    
NSMutableDictionary *listVenue;
NSDictionary *categoryDictionary;
NSMutableArray *categoryArray;
NSMutableDictionary *categoryInfo;
NSMutableDictionary * checkinStats;
NSMutableArray *arrayWithDistance;
BOOL didRunFourSquareParse;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [self startStandardLocationServices];
    // Override point for customization after application launch.
    return YES;
}

-(void) startStandardLocationServices
{
    //if you can't find a location -- then find one...
    if (nil == self.ourLocationManager)
    {
        self.ourLocationManager = [[CLLocationManager alloc] init];
        
        self.ourLocationManager.delegate = self;
        self.ourLocationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        
        // Set a movement threshold for new events.
        self.ourLocationManager.distanceFilter = kCLDistanceFilterNone;
        
        [self.ourLocationManager startUpdatingLocation];
        
        if([CLLocationManager headingAvailable]) {
            [self.ourLocationManager startUpdatingHeading];
        } else {
            //NSLog(@"No Compass -- You're lost");
        }
    }
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
