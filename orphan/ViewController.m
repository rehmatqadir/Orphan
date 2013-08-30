//
//  ViewController.m
//  orphan
//
//  Created by MasterRyuX on 6/30/13.
//  Copyright (c) 2013 MasterRyuX. All rights reserved.
//


#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableArray *arrayWithDistance;
    NSArray *distanceSortedArray;
    NSString *latitudeWithCurrentCoordinates;
    NSString *longitudeWithCurrentCoordinates;
    float ourPhoneFloatLat;
    float ourPhoneFloatLong;
    NSMutableArray * allItems1;
    AppDelegate *appDelegate;
    float thisVenueLat;
    float thisVenueLong;
    float thisDistVenueLat;
    float thisDistVenueLong;
    SLComposeViewController *slComposeViewController;
    UIActivityViewController *uiActivityViewController;
    ACAccount * twitterAccountType;
    
    
}

#define degreesToRadians(x) (M_PI * x / 180.0)
#define radiandsToDegrees(x) (x * 180.0 / M_PI)

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startStandardLocationServices];
	// Do any additional setup after loading the view, typically from a nib.
}


-(void) startStandardLocationServices
{
    //if you can't find a location -- then find one...
    if (nil == locationManager)
    {
        locationManager = [[CLLocationManager alloc] init];
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        
        // Set a movement threshold for new events.
        locationManager.distanceFilter = kCLDistanceFilterNone;
        
        [locationManager startUpdatingLocation];
        
        if([CLLocationManager headingAvailable]) {
            [locationManager startUpdatingHeading];
        } else {
            //NSLog(@"No Compass -- You're lost");
        }
    }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
   
    CLLocation* startLocation = [locations lastObject];

    if (startLocation.coordinate.latitude == 0 && startLocation.coordinate.longitude == 0) {
        
        return;
    }
    
    ourPhoneFloatLat = startLocation.coordinate.latitude;
    ourPhoneFloatLong = startLocation.coordinate.longitude;
    self.strLatitude = [NSString stringWithFormat: @"%f", startLocation.coordinate.latitude];
    self.strLongitude = [NSString stringWithFormat: @"%f", startLocation.coordinate.longitude];
    
    
    thisDistVenueLat = [appDelegate.mateLocation.mateLatitude floatValue];
    thisDistVenueLong = [appDelegate.mateLocation.mateLongitude floatValue];
    //  give latitude2,lang of destination   and latitude,longitude of first place.
    
    //this function return distance in kilometer.
    
    float DistRadCurrentLat = degreesToRadians(startLocation.coordinate.latitude);
    float DistRadCurrentLong = degreesToRadians(startLocation.coordinate.longitude);
    float DistRadthisVenueLat = degreesToRadians(thisDistVenueLat);
    float DistRadthisVenueLong = degreesToRadians(thisDistVenueLong);
    //float deltLat = (radthisVenueLat - radcurrentLat);
    float deltDistLat = (DistRadthisVenueLat - DistRadCurrentLat);
    float deltDistLong = (DistRadthisVenueLong - DistRadCurrentLong);
    
    float a = (sinf(deltDistLat/2) * sinf(deltDistLat/2)) + ((sinf(deltDistLong/2) * sinf(deltDistLong/2)) * cosf(DistRadCurrentLat) * cosf(DistRadthisVenueLat));
    float srootA = sqrtf(a);
    float srootoneMinusA = sqrtf((1-a));
    
    float c = (2 * atan2f(srootA, srootoneMinusA));
    
    float distBetweenStartandVenueMeters = (c * 6371*1000); //radius of earth
    //    NSLog (@"the distance it's logging in m is %f", distBetweenStartandVenueMeters);
    
    float distBetweenStartandVenueFeet = (distBetweenStartandVenueMeters*3.281);
    //    NSLog(@"the distance from foursquare is %@", appDelegate.closestVenue.distance);
    // float distBetweenStartandVenueKilometers = (c * 6371); //radius of earth
    //    NSLog (@"%f", distBetweenStartandVenueKilometers);
    
    //float distBetweenStartandVenueFeet = (distBetweenStartandVenueMeters/3281);
    
    //    NSLog (@"%f", distBetweenStartandVenueFeet);
    self.theDistance = [[NSString alloc] init];
    
    // float distPlaceHolder = [thisNearPlace.distance floatValue];
    int rounding = (distBetweenStartandVenueFeet);
    NSString *distLabel = [[NSString alloc] init];
    if (distBetweenStartandVenueFeet > 10000) {
        distLabel = [NSString stringWithFormat:@"Calculating..."];
        
    }
    
    // if (distBetweenStartandVenueFeet < 75) {
    //   distLabel = [NSString stringWithFormat: @"Less than 100 feet, you're here, look up."];
    
    // }
 
    
    else
        
    {
        distLabel = [NSString stringWithFormat:@"%i feet", rounding];
       // self.saiImage.alpha = 1;
        //self.sadSushiImage.alpha = 0;
    }
    
    // NSString *distLabel = [NSString stringWithFormat:@"%i feet",rounding];
    self.theDistance = distLabel;
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    
    //[self.activityIndicator stopAnimating];
    //[[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    if (!self.headingDidStartUpdating) {
        //[self setupCompassObjectsAndLabels];
        self.headingDidStartUpdating = YES;
    }
    
    thisVenueLat = [appDelegate.mateLocation.mateLatitude floatValue];
    thisVenueLong = [appDelegate.mateLocation.mateLongitude floatValue];
    
    float radcurrentLat = degreesToRadians(ourPhoneFloatLat);
    float radcurrentLong = degreesToRadians(ourPhoneFloatLong);
    float radthisVenueLat = degreesToRadians(thisVenueLat);
    float radthisVenueLong = degreesToRadians(thisVenueLong);
    //float deltLat = (radthisVenueLat - radcurrentLat);
    float deltLong = (radthisVenueLong - radcurrentLong);
    
    float y = sinf(deltLong) * cosf(radthisVenueLat);
    float x = (cosf(radcurrentLat) * sinf(radthisVenueLat)) - ((sinf(radcurrentLat) *cosf(radthisVenueLat)) * cosf(deltLong));
    float radRotateAngle = atan2f(y, x);
    float initialVenueBearing = radRotateAngle;
    float VenueBearDeg;
    
    float initialVenueBearingDegrees = initialVenueBearing * 180/M_PI;
    
    if (initialVenueBearingDegrees < 0) {
        VenueBearDeg = initialVenueBearingDegrees + 360;
    }
    else{
        VenueBearDeg = initialVenueBearingDegrees;
    };
    
    
    // NSLog(@"Initial bearing/initial angle rotation from north in degrees is = %f", VenueBearDeg);
    MateLocation * mateLocation1 = [[MateLocation alloc] init];
    //    appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    mateLocation1 = appDelegate.mateLocation;
    
    
    //trig calculations necessary to display additional navigation information (distance, etc, spherical of cosines).
    // float oldRad =  -manager.heading.trueHeading * M_PI / 180.0f;
    //
    //float newRad =  newHeading.trueHeading * M_PI / 180.0f;
    //float managerheadRad = manager.heading.trueHeading * M_PI/180.0f;
    //float newHeadingRad = newHeading.trueHeading * M_PI /180.0f;
    float angleCalc;
    if (newHeading.trueHeading > VenueBearDeg)
    {angleCalc = -(newHeading.trueHeading - VenueBearDeg);
    }
    else
    {angleCalc = VenueBearDeg - newHeading.trueHeading;
    }
    //float angleCalc = (VenueBearDeg - newHeading.magneticHeading);
    
    // NSLog(@"%@", self.nearestPlaceLabel.text);
    float radAngleCalc = angleCalc * M_PI / 180.0f;
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    //theAnimation.fromValue = [NSNumber numberWithFloat:0];
    //theAnimation.toValue=[NSNumber numberWithFloat:radAngleCalc];
    theAnimation.duration = .8f;
    //self.closeSushiLabel.text = nearPlaceName;
    self.theDistanceLabel.text = self.theDistance;
    
    [self.heartSpinner.layer addAnimation:theAnimation forKey:@"animateMyRotation"];
    self.heartSpinner.transform = CGAffineTransformMakeRotation(radAngleCalc);
   // if (![self connected]) {
     //   self.theDistanceLabel.text = @"No Signal";
        //self.closeSushiLabel.text = @":(";
        //        self.saiImage.alpha = 0;
        //        self.sadSushiImage.alpha = 1;
    }
    
    //NSNumber *distY = thisNearPlace.distance;
    
    // NSLog (@"the distance it's logging in km is %f", distBetweenStartandVenueMeters);
    
    //float distPlaceHolder = [thisNearPlace.distance floatValue];
    //int rounding = (distBetweenStartandVenueMeters);
    
    //NSNumber *disttemp = roundf(distPlaceHolder);
    //    NSString *distLabel = [NSString stringWithFormat:@"%i",rounding];
    //    NSLog(@"%@", distLabel);
    //    self.theDistance = distLabel;
    //
    //
    //NSLog(@"true heading is %f", newHeading.trueHeading);
    
//}



-(IBAction)updateMyLocation:(id)sender{
            NSString *someText = [NSString stringWithFormat:@"%@, %@", self.strLatitude, self.strLongitude];
        NSArray *dataToShare = @[someText] ;
        
        uiActivityViewController = [[UIActivityViewController alloc] initWithActivityItems:dataToShare applicationActivities:nil];
        uiActivityViewController.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeMail, UIActivityTypeMessage, UIActivityTypeCopyToPasteboard,UIActivityTypePostToWeibo, UIActivityTypeAssignToContact];
        [self presentViewController:uiActivityViewController animated:YES completion:^{
            //stuff
        }];
    
    [self reverseTransformedValue:someText];
   // NSLog(@"%@", someText)
    //[self getTweets];
    }

- (id)reverseTransformedValue:(id)value
{ NSString *string = (NSString *) value;
    NSArray  *parts  = [string componentsSeparatedByString: @","];
    return [[CLLocation alloc] initWithLatitude: [parts[0] doubleValue]
                                      longitude: [parts[1] doubleValue]];
}

- (IBAction)tweetRetrieve:(id)sender {
    [self getTweets];
}

- (BOOL)userHasAccessToTwitter
{
    return [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter];
}


//- (void)fetchTimelineForUser:(NSString *)username
//{
//    //  Step 0: Check that the user has local Twitter accounts
//    if ([self userHasAccessToTwitter]) {
//        
//        //  Step 1:  Obtain access to the user's Twitter accounts
//        twitterAccountType = [self.accountStore
//                                             accountTypeWithAccountTypeIdentifier:
//                                             ACAccountTypeIdentifierTwitter];
//        [self.accountStore
//         requestAccessToAccountsWithType:twitterAccountType
//         options:NULL
//         completion:^(BOOL granted, NSError *error) {
//             if (granted) {
//                 //  Step 2:  Create a request
//                 NSArray *twitterAccounts =
//                 [self.accountStore accountsWithAccountType:twitterAccountType];
//                 NSURL *url = [NSURL URLWithString:@"https://api.twitter.com"
//                               @"/1.1/statuses/user_timeline.json"];
//                 NSDictionary *params = @{@"screen_name" : @"MasterRyuxX",
//                                          @"include_rts" : @"0",
//                                          @"trim_user" : @"1",
//                                          @"count" : @"1"};
//                 SLRequest *request =
//                 [SLRequest requestForServiceType:SLServiceTypeTwitter
//                                    requestMethod:SLRequestMethodGET
//                                              URL:url
//                                       parameters:params];
//                 
//                 //  Attach an account to the request
//                 [request setAccount:[twitterAccounts lastObject]];
//                 
//                 //  Step 3:  Execute the request
//                 [request performRequestWithHandler:^(NSData *responseData,
//                                                      NSHTTPURLResponse *urlResponse,
//                                                      NSError *error) {
//                     if (responseData) {
//                         if (urlResponse.statusCode >= 200 && urlResponse.statusCode < 300) {
//                             NSError *jsonError;
//                             NSDictionary *timelineData =
//                             [NSJSONSerialization
//                              JSONObjectWithData:responseData
//                              options:NSJSONReadingAllowFragments error:&jsonError];
//                             
//                             if (timelineData) {
//                                 NSLog(@"Timeline Response: %@\n", timelineData);
//                                 NSLog(@"something came back");
//                             }
//                             else {
//                                 // Our JSON deserialization went awry
//                                 NSLog(@"JSON Error: %@", [jsonError localizedDescription]);
//                             }
//                         }
//                         else {
//                             // The server did not respond successfully... were we rate-limited?
//                             NSLog(@"The response status code is %d", urlResponse.statusCode);
//                         }
//                     }
//                 }];
//             }
//             else {
//                 // Access was not granted, or an error occurred
//                 NSLog(@"%@", [error localizedDescription]);
//             }
//         }];
//    }
//}

-(void)getTweets
{
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:@"MasterRyuX" forKey:@"screen_name"];
//    [params setObject:@"10" forKey:@"count"];
//    [params setObject:@"1" forKey:@"include_entities"];
//    [params setObject:@"1" forKey:@"include_rts"];
//    
    self.username = @"MasterRyuxX";
////    NSURL *url = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/user_timeline.json"];
////    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.twitter.com/1/statuses/user_timeline.json?screen_name=MasterryuxX"]];
//                                                          
//        NSData *response = [NSURLConnection sendSynchronousRequest:request
//                                                                        returningResponse:nil error:nil];
//                                                          
//                                                          NSError *jsonParsingError = nil;
//                                                          NSArray *publicTimeline = [NSJSONSerialization JSONObjectWithData:response
//                                                                                                                    options:0 error:&jsonParsingError];
//                                                          NSDictionary *tweet;
//    
//    {
//        tweet= [publicTimeline objectAtIndex:0];
//        NSLog(@"last message, %@", tweet);
//        //NSLog(@"Statuses: %@”, [tweet objectForKey:@"text"]);
//    }
//    
   // + (SLRequest *)requestForServiceType:(NSString *)serviceType requestMethod:(SLRequestMethod)requestMethod URL:(NSURL *)url parameters:(NSDictionary *)parameters;
    
  //SLRequest *request = [[SLRequest alloc] initWithURL:url parameters:params requestMethod:SLRequestMethodGET];
//    
//    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
//     {
//         if (error != nil)
//         {
//             //  Inspect the contents of error
//             exit(-1);
//         }
//         else
//         {
//             [self fetchJSONData:responseData];
//         }
//     }];
    
    
    {
        // Request access to the Twitter accounts
        ACAccountStore *accountStore = [[ACAccountStore alloc] init];
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error){
            if (granted) {
                NSArray *accounts = [accountStore accountsWithAccountType:accountType];
                // Check if the users has setup at least one Twitter account
                if (accounts.count > 0)
                {
                    ACAccount *twitterAccount = [accounts objectAtIndex:0];
                    // Creating a request to get the info about a user on Twitter
                    SLRequest *twitterInfoRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/users/show.json"] parameters:[NSDictionary dictionaryWithObject:self.username forKey:@"screen_name"]];
                    [twitterInfoRequest setAccount:twitterAccount];
                    // Making the request
                    [twitterInfoRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            // Check if we reached the reate limit
                            if ([urlResponse statusCode] == 429) {
                                NSLog(@"Rate limit reached");
                                return;
                            }
                            // Check if there was an error
                            if (error) {
                                NSLog(@"Error: %@", error.localizedDescription);
                                return;
                            }
                            // Check if there is some response data
                            if (responseData) {
                                NSError *error = nil;
                                NSArray *TWData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                                // Filter the preferred data
                                NSString *screen_name = [(NSDictionary *)TWData objectForKey:@"screen_name"];
                                NSString *name = [(NSDictionary *)TWData objectForKey:@"name"];
                                int followers = [[(NSDictionary *)TWData objectForKey:@"followers_count"] integerValue];
                                int following = [[(NSDictionary *)TWData objectForKey:@"friends_count"] integerValue];
                                int tweets = [[(NSDictionary *)TWData objectForKey:@"statuses_count"] integerValue];
                                NSString *profileImageStringURL = [(NSDictionary *)TWData objectForKey:@"profile_image_url_https"];
                                NSString *bannerImageStringURL =[(NSDictionary *)TWData objectForKey:@"profile_banner_url"];
                                // Update the interface with the loaded data
                              //  nameLabel.text = name;
                                //usernameLabel.text= [NSString stringWithFormat:@"@%@",screen_name];
                                //tweetsLabel.text = [NSString stringWithFormat:@"%i", tweets];
//                                followingLabel.text= [NSString stringWithFormat:@"%i", following];
//                                followersLabel.text = [NSString stringWithFormat:@"%i", followers];
                                  NSString *lastTweet = [[(NSDictionary *)TWData objectForKey:@"status"] objectForKey:@"text"];
                                
                                NSLog(@"last tweet = %@", lastTweet);
                                [self useLocationString:lastTweet];
                                //lastTweetTextView.text= lastTweet;
                                // Get the profile image in the original resolution
                                profileImageStringURL = [profileImageStringURL stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
                                //[self getProfileImageForURLString:profileImageStringURL];
                                // Get the banner image, if the user has one
                             //   if (bannerImageStringURL) {
                               //     NSString *bannerURLString = [NSString stringWithFormat:@"%@/mobile_retina", bannerImageStringURL];
                                 //   [self getBannerImageForURLString:bannerURLString];
                                //} else {
                                  //  bannerImageView.backgroundColor = [UIColor underPageBackgroundColor];
                                //}
                            }
                        });
                    }];
                }
            } else {
                NSLog(@"No access granted");
            }
        }];
    }
    
    
}


- (void) useLocationString:(NSString*)loc
{
    // the location object that we want to initialize based on the string
    CLLocationCoordinate2D location;
    
    // split the string by comma
    NSArray * locationArray = [loc componentsSeparatedByString: @","];
    
    // set our latitude and longitude based on the two chunks in the string
    
    NSString * tempStringLat = [locationArray objectAtIndex:0];
    NSString * tempStringLong = [locationArray objectAtIndex:1];
    
    float tempfloatLat = [tempStringLat floatValue];
    float tempfloatLong = [tempStringLong floatValue];
    
    location = CLLocationCoordinate2DMake(tempfloatLat, tempfloatLong);
    NSLog(@"here is the converted tweet coordinates: %f, %f",location.latitude, location.longitude);
    
    //location.latitude = [[[NSNumber alloc] initWithFloat:[[locationArray objectAtIndex:0] floatValue]]];
    //location.longitude = [[[NSNumber alloc] initWithFloat:[[locationArray objectAtIndex:1] floatValue]]];
    
    // do something with the location
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
