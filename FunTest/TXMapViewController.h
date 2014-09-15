//
//  TXMapViewController.h
//  FunTest
//
//  Created by Steven Cheung on 8/15/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXViewController.h"
#import <MapKit/MapKit.h>

@interface TXMapViewController : TXViewController<MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@end
