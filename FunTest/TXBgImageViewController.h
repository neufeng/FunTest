//
//  TXBgImageViewController.h
//  FunTest
//
//  Created by Steven Cheung on 8/14/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXViewController.h"

@interface TXBgImageViewController : TXViewController {
    int selectBg;
    int horIndex, verIndex;
}

@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;

@end
