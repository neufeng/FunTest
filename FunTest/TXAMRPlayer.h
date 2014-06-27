//
//  TXAMRPlayer.h
//  FunTest
//
//  Created by Steven Cheung on 6/24/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

//使用AudioQueue来实现音频播放功能时最主要的步骤:
//
//1. 打开播放音频文件
//2. 取得或设置播放音频文件的数据格式
//3. 建立播放用的队列
//4. 将缓冲中的数据填充到队列中
//5. 开始播放
//6. 在回调函数中进行队列处理
//
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AudioToolbox/AudioFile.h>

#define NUM_BUFFERS 3

@interface TXAMRPlayer : NSObject {
    NSString *filePath;
    //播放音频文件ID
    AudioFileID audioFile;
    
    //音频流描述对象
    AudioStreamBasicDescription dataFormat;
    
    //音频队列
    AudioQueueRef queue;
    
    SInt64 packetIndex;
    
    UInt32 numPacketsToRead;
    
    UInt32 bufferByteSize;
    
    AudioStreamPacketDescription *packetDescs;
    
    AudioQueueBufferRef buffers[NUM_BUFFERS];
    int * _destate;
    int _hasReadSize;
    FILE* _amrFile;
}

//定义队列为实例属性
@property AudioQueueRef queue;
@property(nonatomic, readonly, getter = isPlaying) BOOL playing;
@property(nonatomic, assign) id delegate;

//播放方法定义
- (void)playFile:(NSString *)path;
- (void)stop;

@end


@protocol TXAMRPlayerDelegate <NSObject>

@optional
- (void)player:(TXAMRPlayer *)player didStartPlayingFile:(NSString *)path;
- (void)player:(TXAMRPlayer *)player didStopPlayingFile:(NSString *)path;

@end
