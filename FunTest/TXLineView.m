//
//  TXLineView.m
//  FunTest
//
//  Created by Steven Cheung on 11/19/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXLineView.h"

@implementation TXLineView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGFloat scale = [[UIScreen mainScreen] scale];
    [[UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.3] setStroke];
    UIBezierPath *path= [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, rect.size.height - 1 - 1/(2*scale))];
    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height - 1 - 1/(2*scale))];
    [path setLineWidth:1/scale];
    [path stroke];
    
    CGContextRestoreGState(context);
}

@end
