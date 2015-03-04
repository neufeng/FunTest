//
//  TXAlViewController.m
//  FunTest
//
//  Created by Steven Cheung on 12/19/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXAlViewController.h"
#import "JSONModelLib.h"
#import "TXQueryInfo.h"

@interface TXAlViewController ()

@end

@implementation TXAlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)handleTopButtonClick:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *preferredLang = [languages objectAtIndex:0];
    NSLog(@"%@", preferredLang);
    
    NSString *countryCode = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    NSString *lang = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
    NSLog(@"%@, %@", countryCode, lang);
}

- (IBAction)handleLeftButtonClick:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSLog(@"%@", NSStringFromCGRect(button.frame));
    NSLog(@"%@", NSStringFromCGPoint(button.center));
    
//    uint8_t bytes[8];
//    arc4random_buf(bytes, 8);
//    long long r = 0;
//    for (int i = 0; i < 8; i++) {
//        printf("%d ", (uint8_t)bytes[i]);
//    }
//    printf("\n");
//    r = ((unsigned long long)bytes[0]<<56) |
//        ((unsigned long long)bytes[0]<<48) |
//        ((unsigned long long)bytes[0]<<40) |
//        ((unsigned long long)bytes[0]<<32) |
//        ((unsigned long long)bytes[0]<<24) |
//        ((unsigned long long)bytes[0]<<16) |
//        ((unsigned long long)bytes[0]<<8) |
//        ((unsigned long long)bytes[0]);
//    NSLog(@"r = %lld", r);
    NSLog(@"rand = %u", arc4random());
}

- (IBAction)handleRightButtonClick:(id)sender {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mc.tx.com.cn/app/recIndex?sys=2"]];
    NSError *error;
    NSHTTPURLResponse *response;
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSLog(@"%d", httpResponse.statusCode);
        NSError *error;
        if (data == nil) {
            return;
        }
        
        NSError *err;
        TXQueryInfo *queryInfo = [[TXQueryInfo alloc] initWithData:data error:&err];
        NSLog(@"%@", queryInfo);
    }];
    
}

- (IBAction)handleAnimateButtonClick:(id)sender {
    [UIView animateWithDuration:1.0 animations:^{
        self.topConst.constant += 100;
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)handleGoogleButtonClick:(id)sender {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&sensor=true"]];
    NSError *error;
    NSHTTPURLResponse *response;
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSLog(@"%d", httpResponse.statusCode);
        
        NSLog(@"%@", data);
        
    }];
}

@end
