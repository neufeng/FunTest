//
//  TXStatusBarViewController.m
//  FunTest
//
//  Created by Steven Cheung on 8/18/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXStatusBarViewController.h"
#import "JDStatusBarNotification.h"
#import "TWMessageBarManager.h"

@interface TXStatusBarViewController ()

@end

@implementation TXStatusBarViewController

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
- (IBAction)handleBackButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)handleShowButtonClick:(id)sender {
    [JDStatusBarNotification showWithStatus:@"你好啊" dismissAfter:3.0];
}
- (IBAction)handleShow2ButtonClick:(id)sender {
    [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"你好啊" description:@"" type:TWMessageBarMessageTypeInfo duration:5.0 callback:^{
        NSLog(@"点击了");
    }];
}

@end
