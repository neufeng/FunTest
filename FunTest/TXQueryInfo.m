//
//  TXQueryInfo.m
//  FunTest
//
//  Created by Steven Cheung on 1/19/15.
//  Copyright (c) 2015 tx. All rights reserved.
//

#import "TXQueryInfo.h"

//  result
@implementation TXQueryInfo

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end


//  home
@implementation TXHomeModel

+(JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"ads" : @"ads",
                                                       @"hotMsgs" : @"hotestMsgs",
                                                       @"newMsgs" : @"newestMsgs",
                                                       }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end


//  ads
@implementation TXAdsModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end


//  msgs
@implementation TXMsgsModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

