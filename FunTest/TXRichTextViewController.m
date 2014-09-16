//
//  TXRichTextViewController.m
//  FunTest
//
//  Created by Steven Cheung on 9/16/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXRichTextViewController.h"

@interface TXRichTextViewController ()

@end

@implementation TXRichTextViewController

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
    
    self.richLabel.emojiDelegate = self;
    self.richLabel.font = [UIFont systemFontOfSize:14.0];
    self.richLabel.isNeedAtAndPoundSign = YES;
    self.richLabel.customEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    self.richLabel.customEmojiPlistName = @"expression.plist";
    self.richLabel.disableThreeCommon = YES;
    self.richLabel.emojiText = @"[微笑] 达人 @小月月 ";

//    [/001]正则
//    \\[/([0-9]{1,3})\\]

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

- (IBAction)handleGenerateButtonClick:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.enabled = NO;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < 100; i++) {
        NSString *value = [NSString stringWithFormat:@"m%03d.png", i];
        NSString *key = [NSString stringWithFormat:@"[/%d]", i];
        [dic setObject:value forKey:key];
    }
    for (int i = 0; i < 104; i++) {
        NSString *value = [NSString stringWithFormat:@"m%03d.png", i];
        NSString *key = [NSString stringWithFormat:@"[/%03d]", i];
        [dic setObject:value forKey:key];
    }
    
    NSString *docDic = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docDic stringByAppendingPathComponent:@"testexpression.plist"];
    BOOL success =[dic writeToFile:path atomically:YES];
    
    NSString *message = [NSString stringWithFormat:@"%d", success];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"生成结果" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
    button.enabled = YES;
}

- (void)mlEmojiLabel:(MLEmojiLabel*)emojiLabel didSelectLink:(NSString*)link withType:(MLEmojiLabelLinkType)type
{
    NSLog(@"link = %@, type = %d", link, type);
}

@end
