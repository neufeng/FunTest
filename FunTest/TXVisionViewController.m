//
//  TXVisionViewController.m
//  FunTest
//
//  Created by Steven Cheung on 7/23/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXVisionViewController.h"

@interface TXVisionViewController ()

@end

@implementation TXVisionViewController

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
    
    [self setup];
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

- (void)setup
{
    theVision = [PBJVision sharedInstance];
    
    //  preview
    previewLayer = [theVision previewLayer];
    previewLayer.frame = self.previewView.bounds;
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.previewView.layer addSublayer:previewLayer];
    [theVision setPresentationFrame:self.previewView.frame];
    
    theVision.delegate = self;
    if ([theVision isCameraDeviceAvailable:PBJCameraDeviceBack]) {
        theVision.cameraDevice = PBJCameraDeviceBack;
    }
    else {
        theVision.cameraDevice = PBJCameraDeviceFront;
    }
    [theVision setCameraMode:PBJCameraModeVideo];
    [theVision setCameraOrientation:PBJCameraOrientationPortrait];
    [theVision setFocusMode:PBJFocusModeAutoFocus];
    [theVision setOutputFormat:PBJOutputFormatSquare];
    [theVision setVideoBitRate:PBJVideoBitRate480x360];
    theVision.videoRenderingEnabled = YES;
    theVision.additionalCompressionProperties = @{AVVideoProfileLevelKey : AVVideoProfileLevelH264Baseline30};
    
    [theVision startPreview];
}

- (IBAction)handleLongGR:(id)sender {
    UILongPressGestureRecognizer *gestureRecognizer = (UILongPressGestureRecognizer *)sender;
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (!recording) {
                [theVision startVideoCapture];
            }
            else {
                [theVision resumeVideoCapture];
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        {
            [theVision pauseVideoCapture];
            break;
        }
        default:
            break;
    }
}

- (IBAction)handleDoneButtonClick:(id)sender {
    [theVision endVideoCapture];
}

- (IBAction)handleSwitchCameraButtonClick:(id)sender {
    theVision.cameraDevice = theVision.cameraDevice == PBJCameraDeviceBack ? PBJCameraDeviceFront : PBJCameraDeviceBack;
}

#pragma mark - PBJVisionDelegate
//  video capture
- (void)visionDidStartVideoCapture:(PBJVision *)vision
{
    NSLog(@"video capture start");
    recording = YES;
}
- (void)visionDidPauseVideoCapture:(PBJVision *)vision
{
    NSLog(@"video capture pause");
}
- (void)visionDidResumeVideoCapture:(PBJVision *)vision
{
    NSLog(@"video capture resume");
}

//  progress
- (void)vision:(PBJVision *)vision didCaptureVideoSampleBuffer:(CMSampleBufferRef)sampleBuffer;
{
//    NSLog(@"captured video (%f) seconds", vision.capturedVideoSeconds);
}

- (void)vision:(PBJVision *)vision capturedVideo:(NSDictionary *)videoDict error:(NSError *)error
{
    recording = NO;
    
    if (error && [error.domain isEqual:PBJVisionErrorDomain] && error.code == PBJVisionErrorCancelled) {
        NSLog(@"recording session cancelled");
        return;
    } else if (error) {
        NSLog(@"encounted an error in video capture (%@)", error);
        return;
    }
    
    currentVideo = videoDict;
    NSString *videoPath = [currentVideo  objectForKey:PBJVisionVideoPathKey];
    NSLog(@"videoPath = %@", videoPath);
}

@end
