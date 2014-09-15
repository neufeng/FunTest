//
//  TXJumpAppStoreViewController.m
//  FunTest
//
//  Created by Steven Cheung on 8/28/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXJumpAppStoreViewController.h"

@interface TXJumpAppStoreViewController ()

@end

@implementation TXJumpAppStoreViewController

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

- (IBAction)handleJumpButtonClick:(id)sender {
    SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
    storeProductVC.delegate = self;
    NSDictionary *productParam = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:908946878] forKey:SKStoreProductParameterITunesItemIdentifier];
    [storeProductVC loadProductWithParameters:productParam completionBlock:^(BOOL result, NSError *error) {
        
    }];
    [self presentViewController:storeProductVC animated:YES completion:nil];
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)handleCallButtonClick:(id)sender {
    [self showCaller];
}

- (void)showCaller
{
    NSArray *syms = [NSThread callStackSymbols];
    if (syms.count > 1) {
        NSString *sourceString = [syms objectAtIndex:1];
        NSLog(@"%@", sourceString);
        NSCharacterSet *separatorSet = [NSCharacterSet characterSetWithCharactersInString:@" -[]+?.,"];
        NSMutableArray *array = [NSMutableArray arrayWithArray:[sourceString  componentsSeparatedByCharactersInSet:separatorSet]];
        [array removeObject:@""];
        if (array.count > 3) {
            NSString *className = [array objectAtIndex:3];
            NSLog(@"Class caller = %@", className);
            NSLog(@"%@", NSClassFromString(className));
        }
    }
}

@end
