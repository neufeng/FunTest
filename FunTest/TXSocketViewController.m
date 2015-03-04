//
//  TXSocketViewController.m
//  FunTest
//
//  Created by Steven Cheung on 12/19/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXSocketViewController.h"

@interface TXSocketViewController ()

@end

@implementation TXSocketViewController

#define kDefaultIp @"192.168.56.198"
#define kDefaultPort 8888

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    int uid = 0;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    uid = [defaults integerForKey:@"TX_MY_UID"];
    if (uid == 0) {
        uid = 1000001 + (uint)arc4random()%10000;
        [defaults setInteger:uid forKey:@"TX_MY_UID"];
        [defaults synchronize];
    }
    myUid = uid;
    NSLog(@"uid = %d", uid);
    
    socketQueue = dispatch_queue_create("SocketTCPQueue", nil);
    delegateQueue = dispatch_queue_create("SocketDelegateQueue", nil);
    mSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:delegateQueue socketQueue:socketQueue];
    
    receiveData = [[NSMutableArray alloc] init];
    if (amrCodec == nil) {
        amrCodec = [[RecordAmrCode alloc] init];
    }
    
    [self initSession];
    [self setupAudioQueue];
    
    //  开启播放队列
    AudioQueueStart(mOutQueue, NULL);
    
//    NSError *error = nil;
//    [mSocket bindToPort:8888 error:&error];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    NSError *error = nil;
    [mSocket connectToHost:kDefaultIp onPort:kDefaultPort error:&error];
    if (error) {
        NSLog(@"error %@", error);
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    if ([mSocket isConnected]) {
        [self sendData:[NSData data] withType:3];
        
        [mSocket close];
    }
    if (mInQueue != nil) {
        AudioQueueStop(mInQueue, YES);
    }
    if (mOutQueue != nil) {
        AudioQueueStop(mOutQueue, YES);
    }
}

- (IBAction)handleStopButtonClick:(id)sender {
    if (recording && mInQueue) {
        AudioQueuePause(mInQueue);
//        AudioQueueStop(mInQueue, YES);
        
        recording = NO;
        [self showTip:@"record stop"];
    }
}

- (IBAction)handleMyRecordButtonClick:(id)sender {
    if (recording == NO) {
        recording = YES;
        
        AudioQueueStart(mInQueue, NULL);
        
        [self showTip:@"recording..."];
    }
    else {
        recording = NO;
        
        AudioQueuePause(mInQueue);
//        AudioQueueStop(mInQueue, YES);
        
        [self showTip:@"record stop"];
    }
}

- (void)sendString:(NSString *)str
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [self sendData:data withType:2];
}

- (char *)int2bytes:(int)i
{
    char *result = (char *)malloc(4*sizeof(char));
    result[0] = (char) ((i >> 24) & 0xFF);
    result[1] = (char) ((i >> 16) & 0xFF);
    result[2] = (char) ((i >> 8) & 0xFF);
    result[3] = (char) (i & 0xFF);
    
    return result;
}

//  type 1-register 2-send
- (void)sendData:(NSData *)data withType:(int)type
{
    char head[9];
    head[0] = (char) ((myUid >> 24) & 0xFF);
    head[1] = (char) ((myUid >> 16) & 0xFF);
    head[2] = (char) ((myUid >> 8) & 0xFF);
    head[3] = (char) (myUid & 0xFF);
    head[4] = (char) (type & 0xFF);
    int len = data.length;
    head[5] = (char) ((len >> 24) & 0xFF);
    head[6] = (char) ((len >> 16) & 0xFF);
    head[7] = (char) ((len >> 8) & 0xFF);
    head[8] = (char) (len & 0xFF);
    NSMutableData *sendData = [[NSMutableData alloc] initWithBytes:head length:9];
    [sendData appendData:data];
    [mSocket sendData:sendData withTimeout:-1 tag:100];
}

#pragma mark - GCDAsyncUdpSocketDelegate
//  socket已连接
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didConnectToAddress:(NSData *)address
{
    [self showTip:@"connect"];
    
    NSError *error = nil;
    [sock beginReceiving:&error];
    if (error) {
        NSLog(@"error %@", error);
    }
    
    [self sendData:[NSData data] withType:1];
}
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotConnect:(NSError *)error;
{
    NSLog(@"not connect %@", error);
}

//  socket数据已发送
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag;
{
    NSLog(@"DidSendData tag = %ld", tag);
    
    [self showTip:[NSString stringWithFormat:@"send %ld", tag]];
}
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    NSLog(@"DidNotSendData tag = %ld %@", tag, error);
}

//  socket读取到数据
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext
{
    NSLog(@"receive %d", data.length);
    
    dispatch_async(dispatch_get_main_queue(), ^{
//        uint8_t *pData = (uint8_t *)data.bytes;
//        unsigned int len = ((pData[5]>>24)&0xFF) + ((pData[6]>>16)&0xFF) + ((pData[7]>>8)&0xFF) + (pData[8]&0xFF);
        if (data.length > 4) {
            if (data.length > 322) {
                int num = data.length / 322;
                int sum = 0;
                for (int i = 0; i < num; i++) {
                    NSData *piceData = [data subdataWithRange:NSMakeRange(i*322, 322)];
                    [receiveData addObject:piceData];
                    sum += 649;
                }
                if (sum < data.length) {
                    NSData *otherData = [data subdataWithRange:NSMakeRange(sum, data.length-sum)];
                    [receiveData addObject:otherData];
                }
            }
            else {
                [receiveData addObject:data];
            }
        }
    });
    
    [self showTip:@"receive"];
}

//  socket断开
- (void)udpSocketDidClose:(GCDAsyncUdpSocket *)sock withError:(NSError *)error
{
    NSLog(@"DidClose %@", [error localizedDescription]);
    
    [self showTip:@"close"];
}

- (void)showTip:(NSString *)tip
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm:ss.SSS"];
        NSString *time = [formatter stringFromDate:[NSDate date]];
        NSString *tipString = [NSString stringWithFormat:@"%@\n%@", time, tip];
        self.descLabel.text = tipString;
    });
}

- (void)audioQueueOutputWithQueue:(AudioQueueRef)inQueue queueBuffer:(AudioQueueBufferRef)inBuffer
{
    NSData *pcmData = nil;
    
    if (receiveData.count > 0) {
        NSData *amrData = [receiveData objectAtIndex:0];
        pcmData = [amrCodec decodeAMRDataToPCMData:amrData];
        
        if (pcmData != nil) {
            if (pcmData.length < 10000) {
                memcpy(inBuffer->mAudioData, pcmData.bytes, pcmData.length);
                inBuffer->mAudioDataByteSize = (UInt32)pcmData.length;
                inBuffer->mPacketDescriptionCount = 0;
            }
        }
        [receiveData removeObjectAtIndex:0];
    }
    else {
        makeSilent(inBuffer);
    }
    AudioQueueEnqueueBuffer(mOutQueue, inBuffer, 0, NULL);
}

static void audioQueueOutputBufferCallback(void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef inAQBuffer)
{
    TXSocketViewController *thisVC = (__bridge TXSocketViewController *)inUserData;
    [thisVC audioQueueOutputWithQueue:inAQ queueBuffer:inAQBuffer];
}
static void isRunningProc(void *inUserData, AudioQueueRef inAQ, AudioQueuePropertyID inID)
{
    
}

- (void)setupAudioFormat
{
    memset(&mAudioFormat, 0, sizeof(mAudioFormat));
    
    mAudioFormat.mSampleRate = 8000;
//    mAudioFormat.mSampleRate = 44100;
    mAudioFormat.mChannelsPerFrame = 1;
    mAudioFormat.mFormatID = kAudioFormatLinearPCM;
    mAudioFormat.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked;
    mAudioFormat.mBitsPerChannel = 16;
    mAudioFormat.mBytesPerPacket = mAudioFormat.mBytesPerFrame = (mAudioFormat.mBitsPerChannel / 8) * mAudioFormat.mChannelsPerFrame;
    mAudioFormat.mFramesPerPacket = 1;
}

- (void)initSession
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //播放并录音模式
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error:nil];
    [audioSession setActive:YES error:nil];
}

- (void)setupAudioQueue
{
    //  设置音频格式
    [self setupAudioFormat];
    
    //  创建录音队列
    AudioQueueNewInput(&mAudioFormat, inputBufferCallbackProc, (__bridge void *)self, NULL, NULL, 0, &mInQueue);
    
    //  创建播放队列
    AudioQueueNewOutput(&mAudioFormat, audioQueueOutputBufferCallback, (__bridge void *)self, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode, 0, &mOutQueue);
    
    //  创建录音缓冲
    for (int i = 0; i < BUFFER_NUM; i++) {
        AudioQueueAllocateBuffer(mInQueue, DEFAULT_INPUT_BUFFER_SIZE, &inBuffers[i]);
        
        AudioQueueEnqueueBuffer(mInQueue, inBuffers[i], 0, NULL);
    }
    //  创建播放缓冲
    for (int i = 0; i < BUFFER_NUM; i++) {
        AudioQueueAllocateBuffer(mOutQueue, DEFAULT_OUTPUT_BUFFER_SIZE, &outBuffers[i]);
        
        makeSilent(outBuffers[i]);
        AudioQueueEnqueueBuffer(mOutQueue, outBuffers[i], 0, NULL);
    }
    
    //  音量
    AudioQueueSetParameter(mOutQueue, kAudioQueueParam_Volume, 1.0);
}

//把缓冲区置空
void makeSilent(AudioQueueBufferRef buffer)
{
    for (int i=0; i < buffer->mAudioDataBytesCapacity; i++) {
        buffer->mAudioDataByteSize = buffer->mAudioDataBytesCapacity;
        UInt8 * samples = (UInt8 *) buffer->mAudioData;
        samples[i]=0;
    }
}

static void inputBufferCallbackProc(void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef inBuffer, const AudioTimeStamp *inStartTime, UInt32 inNumPackets, const AudioStreamPacketDescription *inPacketDesc)
{
    TXSocketViewController *thisVC = (__bridge TXSocketViewController *)inUserData;
    [thisVC handleAudioQueueInput:inAQ inputBuffer:inBuffer inputStartTime:inStartTime inputNumPackets:inNumPackets inputPacketDesc:inPacketDesc];
}

- (void)handleAudioQueueInput:(AudioQueueRef)inAQ inputBuffer:(AudioQueueBufferRef)inBuffer inputStartTime:(const AudioTimeStamp *)inStartTime inputNumPackets:(UInt32)inNumPackets inputPacketDesc:(const AudioStreamPacketDescription *)inPacketDesc
{
    if (inNumPackets > 0) {
        NSLog(@"record size %d", (unsigned int)inBuffer->mAudioDataByteSize);
        NSData *pcmData = [[NSData alloc] initWithBytes:inBuffer->mAudioData length:inBuffer->mAudioDataByteSize];
        if (pcmData && pcmData.length > 0) {
            NSData *amrData = [amrCodec encodePCMDataToAMRData:pcmData];
            [self sendData:amrData withType:2];
        }
    }
    
    if (recording) {
        AudioQueueEnqueueBuffer(inAQ, inBuffer, 0, NULL);
    }
}

@end
