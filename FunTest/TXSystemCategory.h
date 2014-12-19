//
//  TXSystemCategory.h
//  FunTest
//
//  Created by Steven Cheung on 12/18/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXSystemCategory : NSObject

@end


//  aes加密
@interface NSData (NSData_AES)

- (NSData *)Base64EncryptData;
- (NSData *)Base64DecryptData;
- (NSData *)EncryptDataWithKey:(NSString *)key;
- (NSData *)DecryptDataWithKey:(NSString *)key;
- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv;
- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv;
- (NSData *)AES128EncryptWithKey:(NSString *)key;
- (NSData *)AES128DecryptWithKey:(NSString *)key;

@end
