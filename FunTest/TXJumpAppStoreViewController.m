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
    
    NSString *info = @"地方层面到底有多少个领导小组和议事协调机构？群众路线教育实践活动以来，全国一次性减少13万余个。“协调机构”过多、过滥，令人瞠目的数据背后，是对“机构法定”原则淡漠。打着“协同作战”的牌子，挂着“一把手”的旗子，喊着“提高效率”的号子，“领导小组”层出不穷的现象背后，到底是无奈还是无能？在群众路线教育实践活动中，一些省区减少各类领导小组和议事协调机构“成效显著”，仅湖南减少1．3万余个，江苏、内蒙古分别减少8472个和8081个。更多";
    self.testLabel.text = info;
    self.testLablel2.text = @"更多";
    
    NSLog(@"%@", NSStringFromCGRect(self.testLabel.frame));
    CGRect textRect = [self.testLabel textRectForBounds:self.testLabel.bounds limitedToNumberOfLines:6];
    NSLog(@"%@", NSStringFromCGRect(textRect));
    self.testLablel2.frame = CGRectMake(self.testLabel.frame.origin.x+self.testLabel.frame.size.width/2+5, self.testLabel.frame.origin.y+self.testLabel.frame.size.height-textRect.size.height/6-((self.testLabel.frame.size.height-textRect.size.height)/2), self.testLabel.frame.size.width/2, textRect.size.height/6);
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
