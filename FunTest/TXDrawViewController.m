//
//  TXDrawViewController.m
//  FunTest
//
//  Created by Steven Cheung on 10/30/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXDrawViewController.h"

@interface TXDrawViewController ()

@end

@implementation TXDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self initShapeLayer];
//    [self initGestureRecognizer];
    
    [self drawGuide];
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

- (void)initShapeLayer
{
    shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.lineWidth   = 2;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor   = [[UIColor grayColor] colorWithAlphaComponent:0.3f].CGColor;
    shapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:5], [NSNumber numberWithInt:5], nil];
    
    CGPathRef path = CGPathCreateWithRect(CGRectInset(self.view.bounds,
                                                      CGRectGetWidth(self.view.bounds)  / 4.f,
                                                      CGRectGetHeight(self.view.bounds) / 4.f),
                                          NULL);
    shapeLayer.path = path;
    CGPathRelease(path);
    
    [self.view.layer addSublayer:shapeLayer];
}

- (void)initGestureRecognizer
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
//    pan.delegate = self;
    pan.maximumNumberOfTouches = 1;
    
    [self.view addGestureRecognizer:pan];
}

- (void)panGesture:(UIPanGestureRecognizer *)panGesture
{
    static CGPoint startPoint;
    
    if (panGesture.state == UIGestureRecognizerStateBegan)
    {
        shapeLayer.path = NULL;
        
        startPoint = [panGesture locationInView:self.view];
    }
    else if (panGesture.state == UIGestureRecognizerStateChanged)
    {
        CGPoint currentPoint = [panGesture locationInView:self.view];
        CGPathRef path = CGPathCreateWithRect(CGRectMake(startPoint.x, startPoint.y, currentPoint.x - startPoint.x, currentPoint.y - startPoint.y), NULL);
        shapeLayer.path = path;
        CGPathRelease(path);
    }
}

- (void)drawGuide
{
    CGSize size = CGSizeMake(200, 200);
    UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, 200, 200);
    CGContextSetFillColorWithColor(ctx, [[UIColor colorWithWhite:0.0 alpha:0.3] CGColor]);
    CGContextFillRect(ctx, rect);
    //
    rect = CGRectMake(50, 50, 100, 100);
    CGContextSetBlendMode(ctx, kCGBlendModeClear);
    CGContextSetFillColorWithColor(ctx, [[UIColor clearColor] CGColor]);
    CGContextFillRect(ctx, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGRect frame = CGRectMake(60, 80, 200, 200);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    [self.view addSubview:imageView];
}

@end
