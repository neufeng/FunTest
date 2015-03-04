//
//  TXQueryInfo.h
//  FunTest
//
//  Created by Steven Cheung on 1/19/15.
//  Copyright (c) 2015 tx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol TXHomeModel, TXAdsModel, TXMsgsModel;
@class TXHomeModel;

@interface TXQueryInfo : JSONModel

@property (nonatomic, assign) bool error;
@property (nonatomic, strong) NSString *errorMessage;
@property (nonatomic, strong) TXHomeModel *resut;

@end


@protocol TXHomeModel <NSObject>

@end
@interface TXHomeModel : JSONModel

@property (nonatomic, strong) NSArray<TXAdsModel> *ads;
@property (nonatomic, strong) NSArray<TXMsgsModel> *hotestMsgs;
@property (nonatomic, strong) NSArray<TXMsgsModel> *newestMsgs;

@end


@protocol TXAdsModel <NSObject>

@end
@interface TXAdsModel : JSONModel

@property (nonatomic, strong) NSString *hint;
@property (nonatomic, strong) NSString *locale;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *url;

@end


@protocol TXMsgsModel <NSObject>

@end
@interface TXMsgsModel : JSONModel

@property (nonatomic, assign) int comments;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) long long ctime;
@property (nonatomic, strong) NSString *face;
@property (nonatomic, assign) int id;
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, assign) short type;
@property (nonatomic, assign) long long uid;
@property (nonatomic, strong) NSArray<Optional>* xy;

@end
