//
//  TXMapViewController.m
//  FunTest
//
//  Created by Steven Cheung on 8/15/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXMapViewController.h"
#import <AddressBookUI/AddressBookUI.h>

@interface TXMapViewController ()

@end

@implementation TXMapViewController

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

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocation *newLocation = userLocation.location;
    NSLog(@"%f,%f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil && placemarks.count > 0) {
            CLPlacemark *place = [placemarks firstObject];
            NSLog(@"%@", place.name);
            NSString *address = ABCreateStringWithAddressDictionary(place.addressDictionary, NO);
            NSLog(@"%@", address);
            self.addressLabel.text = address;
        }
    }];
}
- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    
}

@end
