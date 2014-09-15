//
//  TXMAMapViewController.m
//  FunTest
//
//  Created by Steven Cheung on 9/15/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXMAMapViewController.h"
#import <AddressBookUI/AddressBookUI.h>
#import "CustomAnnotationView.h"

@interface TXMAMapViewController ()

@end

@implementation TXMAMapViewController
@synthesize maMapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    maMapView.delegate = self;
    maMapView.showsUserLocation = YES;
    maMapView.userTrackingMode = MAUserTrackingModeFollow;
    maMapView.distanceFilter = 10;
    maMapView.desiredAccuracy = kCLLocationAccuracyBest;
    maMapView.zoomLevel = 16;
    maMapView.scaleOrigin = CGPointMake(55, 20);
    
    [self addAnnotations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    NSLog(@"%f %f", maMapView.minZoomLevel, maMapView.maxZoomLevel);
}

//  annotation
- (void)addAnnotations
{
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    //  1
    MAPointAnnotation *red = [[MAPointAnnotation alloc] init];
    red.coordinate = CLLocationCoordinate2DMake(31.230036, 121.437096);
    red.title = @"Red";
    red.subtitle = @"0";
    [annotations addObject:red];
    
    //  2
    MAPointAnnotation *green = [[MAPointAnnotation alloc] init];
    green.coordinate = CLLocationCoordinate2DMake(31.236136, 121.438096);
    green.title = @"Green";
    green.subtitle = @"1";
    [annotations addObject:green];
    
    //  3
    MAPointAnnotation *purple = [[MAPointAnnotation alloc] init];
    purple.coordinate = CLLocationCoordinate2DMake(31.233036, 121.439196);
    purple.title = @"Purple";
    purple.subtitle = @"2";
    [annotations addObject:purple];
    
    [maMapView addAnnotations:annotations];
}

- (IBAction)handleLocateButtonClick:(id)sender {
    [maMapView setCenterCoordinate:maMapView.userLocation.location.coordinate animated:YES];
}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"center (%f, %f)", mapView.centerCoordinate.latitude, mapView.centerCoordinate.longitude);
    NSLog(@"rect %@", MAStringFromMapRect(mapView.visibleMapRect));
    MACoordinateRegion region = mapView.region;
    NSLog(@"span (%f, %f)", region.span.latitudeDelta, region.span.longitudeDelta);
}

- (void)mapViewWillStartLocatingUser:(MAMapView *)mapView
{
    NSLog(@"willStartLocatingUser");
}

- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView
{
    NSLog(@"didStopLocatingUser");
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    NSLog(@"new (%f, %f)", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
//        if (error == nil && placemarks.count > 0) {
//            CLPlacemark *place = [placemarks firstObject];
//            NSLog(@"%@", place.name);
//            NSString *address = ABCreateStringWithAddressDictionary(place.addressDictionary, NO);
//            NSLog(@"%@", address);
//        }
//    }];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        NSString *reuseIdentifier = @"customAnnotation";
//        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
//        if (annotationView == nil) {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
//            annotationView.canShowCallout = YES;
//            annotationView.animatesDrop = YES;
//            annotationView.draggable = NO;
//            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//            annotationView.pinColor = MAPinAnnotationColorRed;
//        }
        
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
        if (annotationView == nil) {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
            annotationView.canShowCallout = NO;
            annotationView.draggable = NO;
            annotationView.calloutOffset = CGPointMake(0, -5);
        }
        
        NSArray *imageArray = [NSArray arrayWithObjects:
                               @"animatedCar_1.png",
                               @"animatedTrain_1.png",
                               @"hema.png", nil];
        NSArray *nameArray = [NSArray arrayWithObjects:
                              @"汽车",
                              @"火车",
                              @"河马", nil];
        MAPointAnnotation *pointAnnotation = (MAPointAnnotation *)annotation;
        int index = [pointAnnotation.subtitle intValue];
        annotationView.portrait = [UIImage imageNamed:imageArray[index]];
        annotationView.name = nameArray[index];
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
//    MAAnnotationView *view = [views firstObject];
//    if ([view.annotation isKindOfClass:[MAUserLocation class]]) {
//        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
//        pre.strokeColor = [UIColor blueColor];
//        pre.fillColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.3];
//        pre.lineWidth = 2;
//        
//        [mapView updateUserLocationRepresentation:pre];
//    }
}

//- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
//{
//    return nil;
//}

@end
