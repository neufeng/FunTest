//
//  TXJumpAppStoreViewController.h
//  FunTest
//
//  Created by Steven Cheung on 8/28/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXViewController.h"
#import <StoreKit/StoreKit.h>

@interface TXJumpAppStoreViewController : TXViewController<SKStoreProductViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *testLabel;
@property (strong, nonatomic) IBOutlet UILabel *testLablel2;

@end
