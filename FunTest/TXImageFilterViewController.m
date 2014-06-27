//
//  TXImageFilterViewController.m
//  FunTest
//
//  Created by Steven Cheung on 6/26/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXImageFilterViewController.h"
#import "ImageUtil.h"
#import "ColorMatrix.h"

@interface TXImageFilterViewController ()

@end

@implementation TXImageFilterViewController

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
    
    originImage = [UIImage imageNamed:@"0.png"];
    self.imageView.image = originImage;
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

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(640, 100);
}

- (IBAction)handleSelectChanged:(id)sender {
    switch (self.segmentControl.selectedSegmentIndex) {
        case 0:
        {
            self.imageView.image = originImage;
        }
            break;
        case 1:
        {
            self.imageView.image = [ImageUtil imageWithImage:originImage withColorMatrix:colormatrix_lomo];
            
        }
            break;
        case 2:
        {
            self.imageView.image = [ImageUtil imageWithImage:originImage withColorMatrix:colormatrix_heibai];
        }
            break;
        case 3:
        {
            self.imageView.image = [ImageUtil imageWithImage:originImage withColorMatrix:colormatrix_huajiu];
            
        }
            break;
        case 4:
        {
            self.imageView.image = [ImageUtil imageWithImage:originImage withColorMatrix:colormatrix_gete];
        }
            break;
        case 5:
        {
            self.imageView.image = [ImageUtil imageWithImage:originImage withColorMatrix:colormatrix_ruise];
        }
            break;
        case 6:
        {
            self.imageView.image = [ImageUtil imageWithImage:originImage withColorMatrix:colormatrix_danya];
        }
            break;
        case 7:
        {
            self.imageView.image = [ImageUtil imageWithImage:originImage withColorMatrix:colormatrix_jiuhong];
        }
            break;
        case 8:
        {
            self.imageView.image = [ImageUtil imageWithImage:originImage withColorMatrix:colormatrix_qingning];
        }
            break;
        case 9:
        {
            self.imageView.image = [ImageUtil imageWithImage:originImage withColorMatrix:colormatrix_langman];
        }
            break;
        case 10:
        {
            self.imageView.image = [ImageUtil imageWithImage:originImage withColorMatrix:colormatrix_guangyun];
        }
            break;
        case 11:
        {
            self.imageView.image = [ImageUtil imageWithImage:originImage withColorMatrix:colormatrix_landiao];
        }
            break;
        case 12:
        {
            self.imageView.image = [ImageUtil imageWithImage:originImage withColorMatrix:colormatrix_menghuan];
        }
            break;
        case 13:
        {
            self.imageView.image = [ImageUtil imageWithImage:originImage withColorMatrix:colormatrix_yese];
        }
        default:
            break;
    }
}

- (IBAction)handleConfirmButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
