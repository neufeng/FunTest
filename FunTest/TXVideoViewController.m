//
//  TXVideoViewController.m
//  FunTest
//
//  Created by Steven Cheung on 7/31/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXVideoViewController.h"

@interface TXVideoViewController ()

@end

@implementation TXVideoViewController

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

- (IBAction)handlePlayButtonClick:(id)sender {
//    NSURL *url = [NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"];
    NSURL *url = [NSURL URLWithString:@"http://mull.tx.com.cn/music/ap/mp4/27/140725/1406281678066.mp4"];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    player = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = self.videoView.bounds;
    [self.videoView.layer addSublayer:playerLayer];
    [player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        NSLog(@"time %lld %d", time.value, time.timescale);
    }];
    [player play];
}

@end
