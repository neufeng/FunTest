//
//  TXMAMapViewController.h
//  FunTest
//
//  Created by Steven Cheung on 9/15/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXViewController.h"
#import <MAMapKit/MAMapKit.h>

@interface TXMAMapViewController : TXViewController<MAMapViewDelegate> {
    
}

@property (strong, nonatomic) IBOutlet MAMapView *maMapView;

@end
