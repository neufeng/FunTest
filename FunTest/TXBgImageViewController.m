//
//  TXBgImageViewController.m
//  FunTest
//
//  Created by Steven Cheung on 8/14/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXBgImageViewController.h"

@interface TXBgImageViewController ()

@end

@implementation TXBgImageViewController

const int kImageCount = 9;
const int kImageVerCount = 10;

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
    
    selectBg = 1; horIndex = 1; verIndex = 0;
    NSString *imageName = [NSString stringWithFormat:@"%03d.jpg", selectBg];
    self.bgImageView.image = [UIImage imageNamed:imageName];
    
    UISwipeGestureRecognizer *leftSwipe1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleBackgroundImageSwipe:)];
    leftSwipe1.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.bgImageView addGestureRecognizer:leftSwipe1];
    
    UISwipeGestureRecognizer *rightSwipe1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleBackgroundImageSwipe:)];
    rightSwipe1.direction = UISwipeGestureRecognizerDirectionRight;
    [self.bgImageView addGestureRecognizer:rightSwipe1];
    
    UISwipeGestureRecognizer *upSwipe1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleBackgroundImageSwipe:)];
    upSwipe1.direction = UISwipeGestureRecognizerDirectionUp;
    [self.bgImageView addGestureRecognizer:upSwipe1];
    
    UISwipeGestureRecognizer *downSwipe1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleBackgroundImageSwipe:)];
    downSwipe1.direction = UISwipeGestureRecognizerDirectionDown;
    [self.bgImageView addGestureRecognizer:downSwipe1];
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

- (void)handleBackgroundImageSwipe:(id)sender
{
    UISwipeGestureRecognizer *swipe = (UISwipeGestureRecognizer *)sender;
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        horIndex++;
    }
    else if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        horIndex--;
    }
    else if (swipe.direction == UISwipeGestureRecognizerDirectionUp) {
        verIndex++;
    }
    else if (swipe.direction == UISwipeGestureRecognizerDirectionDown) {
        verIndex--;
    }
    //
    [self switchBackgroundImage];
}
- (void)switchBackgroundImage
{
    if (horIndex <= 0) {
        horIndex = kImageCount;
    }
    else if (horIndex > kImageCount) {
        horIndex = 1;
    }
    if (verIndex < 0) {
        verIndex = kImageVerCount;
    }
    else if (verIndex > kImageVerCount) {
        verIndex = 0;
    }
    
    selectBg = horIndex + verIndex*10;
    
//    if (selectBg <= 0) {
//        selectBg = kImageCount;
//    }
//    else if (selectBg > kImageCount) {
//        selectBg = 1;
//    }
    NSString *imageName = [NSString stringWithFormat:@"%03d.jpg", selectBg];
    self.bgImageView.image = [UIImage imageNamed:imageName];
}

@end
