//
//  TXScrollImageViewController.m
//  FunTest
//
//  Created by Steven Cheung on 7/3/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXScrollImageViewController.h"

@interface TXScrollImageViewController ()

@end

@implementation TXScrollImageViewController

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
    
    self.scrollView.contentSize = CGSizeMake(2*320+10, self.scrollView.frame.size.height);
    
    NSLog(@"imageview%@ imageview2%@", NSStringFromCGRect(self.scrollImageView.frame), NSStringFromCGRect(self.scrollImageView2.frame));
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"scrollSize %@", NSStringFromCGSize(self.scrollView.contentSize));
    count = 1000;
    
//    [self startScrollImage];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0/200 target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
}

- (void)startScrollImage
{
    self.scrollView.contentOffset = CGPointZero;
    [UIView animateWithDuration:3.0 animations:^{
        self.scrollView.contentOffset = CGPointMake(320, 0);
    } completion:^(BOOL finished) {
        if (finished) {
            [self performSelector:@selector(startScrollImage) withObject:nil];
        }
    }];
}

- (void)handleTimer:(NSTimer *)timer
{
//    if (count > 10000) {
//        [timer invalidate];
//        return;
//    }
//    
//    self.numLabel.text = [NSString stringWithFormat:@"%d", count++];
    CGPoint offset = self.scrollView.contentOffset;
    if (offset.x >= 320) {
        self.scrollView.contentOffset = CGPointZero;
        return;
    }
    self.scrollView.contentOffset = CGPointMake(offset.x+1, offset.y);
}

@end
