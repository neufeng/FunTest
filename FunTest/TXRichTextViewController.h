//
//  TXRichTextViewController.h
//  FunTest
//
//  Created by Steven Cheung on 9/16/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXViewController.h"
#import "MLEmojiLabel.h"

@interface TXRichTextViewController : TXViewController<MLEmojiLabelDelegate>

@property (strong, nonatomic) IBOutlet MLEmojiLabel *richLabel;

@end
