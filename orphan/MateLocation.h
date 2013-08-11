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

@property (strong, nonatomic) NSString  *mateName;
@property (strong, nonatomic) NSString  *address;
@property (strong, nonatomic) NSString  *mateLatitude;
@property (strong, nonatomic) NSString  *mateLongitude;
@property (strong, nonatomic) NSNumber  *distance;
@property (strong, nonatomic) NSString  *subtitle;
@property (strong, nonatomic) NSString  *title;
@property (strong, nonatomic) UIImage *BigPic;
@property (strong, nonatomic) NSData *Icon;
@property float latestBearing;

@property CLLocationCoordinate2D *coordinate;





@end
