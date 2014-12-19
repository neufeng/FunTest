//
//  TXSystemCategory.m
//  FunTest
//
//  Created by Steven Cheung on 12/18/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXSystemCategory.h"

@implementation TXSystemCategory

@end



#import <CommonCrypto/CommonCryptor.h>
@implementation NSData (NSDATA_AES)

- (NSData *)AES128Operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv
{
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [self bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
    }
    free(buffer);
    return nil;
}

- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv
{
    return [self AES128Operation:kCCEncrypt key:key iv:iv];
}

- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv
{
    return [self AES128Operation:kCCDecrypt key:key iv:iv];
}

- (NSData *)AES128Operation:(CCOperation)operation key:(NSString *)key
{
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [self bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
    }
    free(buffer);
    return nil;
}

- (NSData *)AES128EncryptWithKey:(NSString *)key
{
    return [self AES128Operation:kCCEncrypt key:key];
}

- (NSData *)AES128DecryptWithKey:(NSString *)key
{
    return [self AES128Operation:kCCDecrypt key:key];
}

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
// base64编码
- (NSData *)Base64EncryptData
{
    NSData *data = self;
    if ([data length] == 0) {
        return [NSData data];
    }
    
    char *characters = (char *)malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL) {
        return nil;
    }
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length]) {
        char buffer[3] = {0, 0, 0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length]) {
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        }
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1) {
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        }
        else {
            characters[length++] = '=';
        }
        if (bufferLength > 2) {
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        }
        else {
            characters[length++] = '=';
        }
    }
    
    return [[NSData alloc] initWithBytesNoCopy:characters length:length freeWhenDone:YES];
}

// base64解码
- (NSData *)Base64DecryptData
{
    NSData *data = self;
    if (data == nil) {
        return [NSData data];
    }
    if ([data length] == 0) {
        return [NSData data];
    }
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL) {
        decodingTable = (char *)malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++) {
            decodingTable[(short)encodingTable[i]] = i;
        }
    }
    
    const char *characters = (char *)malloc([data length] + 1);
    [data getBytes:(void *)characters length:[data length]];
    if (characters == NULL) {
        return nil;
    }
    char *bytes = (char *)malloc((([data length] + 3) / 4) * 3);
    if (bytes == NULL) {
        return nil;
    }
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES) {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++) {
            if (characters[i] == '\0') {
                break;
            }
            if (isspace(characters[i]) || characters[i] == '=') {
                continue;
            }
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX) {      //  Illegal character!
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0) {
            break;
        }
        if (bufferLength == 1) {     //  At least two characters are needed to produce one byte!
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2) {
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        }
        if (bufferLength > 3) {
            bytes[length++] = (buffer[2] << 6) | buffer[3];
        }
    }
    
    bytes = (char *)realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

- (NSData *)EncryptDataWithKey:(NSString *)key
{
    NSData *encryptData = [self AES128EncryptWithKey:key];
    NSData *base64Data = [encryptData Base64EncryptData];
    
    return base64Data;
}

- (NSData *)DecryptDataWithKey:(NSString *)key
{
    NSData *base64Data = [self Base64DecryptData];
    NSData *decryptData = [base64Data AES128DecryptWithKey:key];
    
    return decryptData;
}

@end
