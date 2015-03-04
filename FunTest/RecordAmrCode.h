//
//  RecordAmrCode.h
//  VoiceChat
//
//  Created by MacOS on 14-9-15.
//  Copyright (c) 2014年 MacOS. All rights reserved.
//

/**
 *  使用audioqueque来实时录音，边录音边转码，可以设置自己的转码方式。从PCM数据转
 */

#import <Foundation/Foundation.h>

@interface RecordAmrCode : NSObject

//将PCM格式Data进行编码，转换为AMR格式
- (NSData *)encodePCMDataToAMRData:(NSData *)pcmData;

//讲AMR格式Data解码，转换为PCM格式
- (NSData *)decodeAMRDataToPCMData:(NSData *)amrData;

@end
