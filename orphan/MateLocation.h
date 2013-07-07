//
//  MateLocation.h
//  orphan
//
//  Created by MasterRyuX on 7/6/13.
//  Copyright (c) 2013 MasterRyuX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MateLocation : NSObject <MKAnnotation>

@property (strong, nonatomic) NSString  *venueName;
@property (strong, nonatomic) NSString  *address;
@property (strong, nonatomic) NSString  *mateLatitude;
@property (strong, nonatomic) NSString  *mateLongitude;
@property (strong, nonatomic) NSNumber  *distance;
@property (strong, nonatomic) NSString  *checkinsCount;
@property (strong, nonatomic) NSString  *rating;
@property (strong, nonatomic) NSString  *hours;
@property (strong, nonatomic) NSString  *subtitle;
@property (strong, nonatomic) NSString  *title;

@property (strong, nonatomic) UIImage *venueBigPic;
@property (strong, nonatomic) NSData *venueTypeIcon;
@property (strong, nonatomic) NSData *venuePic;
@property (strong, nonatomic) NSString *iconURL;
@property (strong, nonatomic) NSString *venueCategory;

@property (nonatomic) CLLocationCoordinate2D coordinate;





@end
