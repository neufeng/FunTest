//
//  TXImagePickerController.m
//  FunTest
//
//  Created by Steven Cheung on 6/30/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXImagePickerController.h"

@interface TXImagePickerController ()

@end

@implementation TXImagePickerController

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
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    button.frame = CGRectMake(self.view.frame.size.width-54, self.view.frame.size.height-44, 64, 44);
//    [button setTitle:@"选择" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(handlePickClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
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

- (id)initWithDelegate:(id)aDelegate
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.allowsEditing = YES;
        self.pickerDelegate = aDelegate;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    for (UIView *subview in [self.view subviews]) {
//        NSLog(@"%@", subview);
//    }
    
//    UIView *PLCameraView = [self findView:self.view withName:@"PLCameraView"];
//    NSLog(@"%@", PLCameraView);
//    UIView *PLCropOverlay = [self findView:PLCameraView withName:@"PLCropOverlay"];
//    NSLog(@"PLCropOverlay");
//    UIView *TPBottomDualButtonBar = [self findView:PLCropOverlay withName:@"TPBottomDualButtonBar"];
//    NSLog(@"%@", TPBottomDualButtonBar);
//    UIView *TPPushButton = [self findView:TPBottomDualButtonBar withName:@"TPPushButton"];
//    NSLog(@"%@", TPPushButton);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    for (UIView *subview in [self.view subviews]) {
//        NSLog(@"%@", subview);
//    }
//    NSLog(@"%@", self.toolbar);
}

- (UIView *)findView:(UIView *)aView withName:(NSString *)name
{
    Class cls = [aView class];
    NSString *desc = [cls description];
    
    if ([name isEqualToString:desc]) {
        return aView;
    }
    
    for (NSUInteger i = 0; i < [aView.subviews count]; i++) {
        UIView *subView = [aView.subviews objectAtIndex:i];
        subView = [self findView:subView withName:name];
        if (subView) {
            return subView;
        }
    }
    
    return nil;
}

- (void)handlePickLocalButtonClick:(id)sender
{
    internalPicker = [[UIImagePickerController alloc] init];
    internalPicker.delegate = self;
    internalPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    internalPicker.allowsEditing = YES;
    [self presentViewController:internalPicker animated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    NSLog(@"%@", viewController);
    
    if (internalPicker != nil) {
        return;
    }
    
    //  cameraView
    UIView *PLCameraView = [self findView:viewController.view withName:@"PLCameraView"];
//    NSLog(@"%@", PLCameraView);
    if (PLCameraView == nil) {
        return;
    }
    //    UIView *PLCropOverlay = [self findView:PLCameraView withName:@"PLCropOverlay"];
    //    NSLog(@"%@", PLCropOverlay);
    
    //  bottomBar
    UIView *bottomBar=[self findView:PLCameraView withName:@"PLCropOverlayBottomBar"];
//    NSLog(@"%@", bottomBar);
    if (bottomBar == nil) {
        return;
    }
    
    //    UIView *TPBottomDualButtonBar = [self findView:PLCropOverlay withName:@"TPBottomDualButtonBar"];
    //    NSLog(@"%@", TPBottomDualButtonBar);
    //    UIView *TPPushButton = [self findView:bottomBar withName:@"TPPushButton"];
    //    NSLog(@"%@", TPPushButton);
    
    //Get ImageView For Camera
    if (bottomBar.subviews.count > 1) {
        UIImageView *bottomBarImageForCamera = [bottomBar.subviews objectAtIndex:1];
//        NSLog(@"%@", bottomBarImageForCamera);
        if (bottomBarImageForCamera.subviews.count > 1) {
            //Get Button 0(The Capture Button)
//            UIButton *cameraButton=[bottomBarImageForCamera.subviews objectAtIndex:0];
//            NSLog(@"%@", cameraButton);
            //Get Button 1
            UIButton *cancelButton=[bottomBarImageForCamera.subviews objectAtIndex:1];
//            NSLog(@"%@", cancelButton);
            if (cancelButton != nil) {
                CGRect frame = cancelButton.frame;
                CGRect rect = frame;
                frame.origin.x = bottomBarImageForCamera.frame.size.width - 6 - frame.size.width;
                cancelButton.frame = frame;
                
                UIButton *pickButton = [UIButton buttonWithType:UIButtonTypeCustom];
                pickButton.frame = rect;
                [pickButton setImage:[UIImage imageNamed:@"library.png"] forState:UIControlStateNormal];
                [pickButton setImage:[UIImage imageNamed:@"library.png"] forState:UIControlStateHighlighted];
                [pickButton addTarget:self action:@selector(handlePickLocalButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [bottomBarImageForCamera addSubview:pickButton];
            }
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (picker == internalPicker) {
        [picker dismissViewControllerAnimated:NO completion:^{
            internalPicker = nil;
        }];
    }
    
    if (self.pickerDelegate && [self.pickerDelegate respondsToSelector:@selector(imagePickerController:didFinishPickingMediaWithInfo:)]) {
        [self.pickerDelegate imagePickerController:self didFinishPickingMediaWithInfo:info];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        internalPicker = nil;
    }];
}

@end
