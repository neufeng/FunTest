//
//  TXImageFilterViewController.h
//  FunTest
//
//  Created by Steven Cheung on 6/26/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXImageFilterViewController : UIViewController {
    UIImage *originImage;
}

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;
- (IBAction)handleSelectChanged:(id)sender;
- (IBAction)handleConfirmButtonClick:(id)sender;

@end
