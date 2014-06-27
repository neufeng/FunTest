//
//  TXMaskView.m
//  FunTest
//
//  Created by Steven Cheung on 6/17/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXMaskView.h"

@implementation TXMaskView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.transparentRect = CGRectZero;
        self.maskColorRef = [[UIColor whiteColor] CGColor];
    }
    return self;
}

///*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    //  top
    CGRect topRect = CGRectMake(0, 0, rect.size.width, self.transparentRect.origin.y);
    CGContextSetFillColorWithColor(context, self.maskColorRef);
    CGContextFillRect(context, topRect);
    //  center
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, self.transparentRect);
    //  bottom
    CGRect bottomRect = CGRectMake(0, self.transparentRect.origin.y + self.transparentRect.size.height, rect.size.width, rect.size.height - self.transparentRect.origin.y - self.transparentRect.size.height);
    CGContextSetFillColorWithColor(context, self.maskColorRef);
    CGContextFillRect(context, bottomRect);
    
    CGContextRestoreGState(context);
}
//*/

@end
