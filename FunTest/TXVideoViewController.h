//
//  TXVideoViewController.h
//  FunTest
//
//  Created by Steven Cheung on 7/31/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface TXVideoViewController : UIViewController {
    AVPlayer *player;
}

@property (strong, nonatomic) IBOutlet UIView *videoView;

@end
