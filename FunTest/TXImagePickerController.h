//
//  TXImagePickerController.h
//  FunTest
//
//  Created by Steven Cheung on 6/30/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXImagePickerController : UIImagePickerController<UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UIImagePickerController *internalPicker;
}

@property(nonatomic, assign) id pickerDelegate;

- (id)initWithDelegate:(id)aDelegate;

@end
