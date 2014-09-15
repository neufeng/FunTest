//
//  TXScrollImageViewController.h
//  FunTest
//
//  Created by Steven Cheung on 7/3/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXScrollImageViewController : UIViewController {
    int count;
}

@property (strong, nonatomic) IBOutlet UILabel *numLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *scrollImageView;
@property (strong, nonatomic) IBOutlet UIImageView *scrollImageView2;

@end
