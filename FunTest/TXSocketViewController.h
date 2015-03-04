//
//  TXSocketViewController.h
//  FunTest
//
//  Created by Steven Cheung on 12/19/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXViewController.h"
#import "GCDAsyncSocket.h"
#import "GCDAsyncUdpSocket.h"
#import <AudioToolbox/AudioToolbox.h>
#import "RecordAmrCode.h"

#define BUFFER_NUM 3
#define DEFAULT_INPUT_BUFFER_SIZE 7360
#define DEFAULT_OUTPUT_BUFFER_SIZE 7040

@interface TXSocketViewController : TXViewController<NSStreamDelegate, AVAudioPlayerDelegate> {
    dispatch_queue_t socketQueue, delegateQueue;
    GCDAsyncUdpSocket *mSocket;
    NSMutableArray *receiveData;
    int myUid;
    
    AudioStreamBasicDescription mAudioFormat;
    AudioQueueRef mInQueue;
    AudioQueueBufferRef inBuffers[BUFFER_NUM];
    
    BOOL recording;
    
    AudioQueueRef mOutQueue;
    AudioQueueBufferRef outBuffers[BUFFER_NUM];
    BOOL isRunning;
    
    RecordAmrCode *amrCodec;
}

@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;

@end
