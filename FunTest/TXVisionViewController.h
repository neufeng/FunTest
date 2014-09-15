//
//  TXVisionViewController.h
//  FunTest
//
//  Created by Steven Cheung on 7/23/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBJVision.h"

@interface TXVisionViewController : UIViewController<PBJVisionDelegate> {
    PBJVision *theVision;
    __block NSDictionary *currentVideo;
    AVCaptureVideoPreviewLayer *previewLayer;
    BOOL recording;
}

@property (strong, nonatomic) IBOutlet UIView *previewView;
@property (strong, nonatomic) IBOutlet UIButton *switchCameraButton;
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;

- (IBAction)handleLongGR:(id)sender;
- (IBAction)handleDoneButtonClick:(id)sender;
- (IBAction)handleSwitchCameraButtonClick:(id)sender;

@end
