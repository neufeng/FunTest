//
//  TXAMRRecorder.h
//  FunTest
//
//  Created by Steven Cheung on 6/24/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#include <AudioToolbox/AudioToolbox.h>
#include <Foundation/Foundation.h>
#include <libkern/OSAtomic.h>

#define kNumberRecordBuffers    3

@interface TXAMRRecorder : NSObject {
    NSString*                   mFileName;
    AudioQueueRef               mQueue;
    AudioQueueBufferRef         mBuffers[kNumberRecordBuffers];
    AudioFileID                 mRecordFile;
    SInt64                      mRecordPacket; // current packet number in record file
    AudioStreamBasicDescription mRecordFormat;
    BOOL                     mIsRunning;
    
    UInt64          startTime;
    FILE *_AmrFile;
    int* _destate;
}

@property(nonatomic, assign) CGFloat mFileDuration;

- (UInt32)getNumberChannels;
- (NSString *)getFileName;
- (AudioQueueRef)getQueue;
- (AudioStreamBasicDescription)getDataFormat;

- (void)startRecord:(NSString *)inRecordFile;
- (void)stopRecord;
- (BOOL)isRunning;
- (void)encodeBuffer:(short *)buf length:(int)len;

//class TXAMRRecorder
//{
//public:
//    TXAMRRecorder();
//    ~TXAMRRecorder();
//    
//    UInt32                      GetNumberChannels() const   { return mRecordFormat.mChannelsPerFrame; }
//    CFStringRef                 GetFileName() const         { return mFileName; }
//    AudioQueueRef               Queue() const               { return mQueue; }
//    AudioStreamBasicDescription    DataFormat() const          { return mRecordFormat; }
//    
//    void            StartRecord(CFStringRef inRecordFile);
//    void            StopRecord();
//    Boolean         IsRunning() const           { return mIsRunning; }
//    
//    void EncodeBuffer(short* buf,int len);
//
//    UInt64          startTime;
//    CGFloat mFileDuration;
//    
//    FILE *_AmrFile;
//    int* _destate;
//};

@end
