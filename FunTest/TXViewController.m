//
//  TXViewController.m
//  FunTest
//
//  Created by Steven Cheung on 6/17/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXViewController.h"
#import "TXMaskView.h"
#import "SoundTouch.h"
#import "TXImageFilterViewController.h"

@interface TXViewController ()

@end

@implementation TXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    CGRect frame = self.view.bounds;
//    TXMaskView *maskView = [[TXMaskView alloc] initWithFrame:frame];
//    maskView.transparentRect = CGRectMake(0, 80, 320, 100);
//    maskView.maskColorRef = [[UIColor colorWithWhite:0.0 alpha:0.6] CGColor];
//    [self.view addSubview:maskView];
    
    player = [[TXAMRPlayer alloc] init];
    player.delegate = self;
    recorder = [[TXAMRRecorder alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleRecordButtonClick:(id)sender {
    if ([recorder isRunning]) {
        [recorder stopRecord];
        
        [self.recordBtn setTitle:@"Record" forState:UIControlStateNormal];
    }
    else {
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *path = [docPath stringByAppendingPathComponent:@"1.amr"];
        [recorder startRecord:path];
        
        self.infoLabel.text = [NSString stringWithFormat:@"record %@", path];
        [self.recordBtn setTitle:@"Recording" forState:UIControlStateNormal];
    }
}

- (IBAction)handlePlayButtonClick:(id)sender {
    if (player.playing) {
        [player stop];
    }
    else {
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *path = [docPath stringByAppendingPathComponent:@"1.amr"];
        [player playFile:path];
    }
}

- (void)player:(TXAMRPlayer *)player didStartPlayingFile:(NSString *)path
{
    self.infoLabel.text = path;
    
    [self.playBtn setTitle:@"Playing" forState:UIControlStateNormal];
}
- (void)player:(TXAMRPlayer *)player didStopPlayingFile:(NSString *)path
{
    self.infoLabel.text = path;
    
    [self.playBtn setTitle:@"Stoped" forState:UIControlStateNormal];
}

- (IBAction)handleRecordWavButtonClick:(id)sender {
    if (wavRecorder && wavRecorder.recording) {
        [wavRecorder stop];
    }
    else {
        NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       [NSNumber numberWithFloat:8000.0], AVSampleRateKey, //采样率
                                       [NSNumber numberWithInt:kAudioFormatLinearPCM], AVFormatIDKey,
                                       [NSNumber numberWithInt:16], AVLinearPCMBitDepthKey,//采样位数 默认 16
                                       [NSNumber numberWithInt:1], AVNumberOfChannelsKey,//通道的数目
                                       //                                   [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,//大端还是小端 是内存的组织方式
                                       //                                   [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,//采样信号是整数还是浮点数
                                       //                                   [NSNumber numberWithInt: AVAudioQualityMedium],AVEncoderAudioQualityKey,//音频编码质量
                                       nil];
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *path = [docPath stringByAppendingPathComponent:@"1.wav"];
        
        wavRecorder = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:path] settings:recordSetting error:nil];
        wavRecorder.delegate = self;
        [wavRecorder prepareToRecord];
        [wavRecorder record];
        [self.recordWavBtn setTitle:@"录音中..." forState:UIControlStateNormal];
    }
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    [self.recordWavBtn setTitle:@"录音" forState:UIControlStateNormal];
}

- (IBAction)handleChangeVoiceButtonClick:(id)sender {
    soundtouch::SoundTouch mSoundTouch;
    mSoundTouch.setSampleRate(8000);
    mSoundTouch.setChannels(1);
    mSoundTouch.setTempoChange(0.0);    //  节拍
    mSoundTouch.setPitchSemiTones(5);  //  音调
    mSoundTouch.setRateChange(0.0);    //  频率
    mSoundTouch.setSetting(SETTING_USE_QUICKSEEK, TRUE);
    mSoundTouch.setSetting(SETTING_USE_AA_FILTER, FALSE);
//    mSoundTouch.setSetting(SETTING_SEQUENCE_MS, 40);
//    mSoundTouch.setSetting(SETTING_SEEKWINDOW_MS, 16);
//    mSoundTouch.setSetting(SETTING_OVERLAP_MS, 8);
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docPath stringByAppendingPathComponent:@"1.wav"];
    NSData *wavData = [[NSData alloc] initWithContentsOfFile:path];
    short *pcmData = (short *)wavData.bytes;
    int pcmSize = (int)wavData.length;
    int nSamples = pcmSize / sizeof(short);
    mSoundTouch.putSamples(pcmData, nSamples);
    short *samples = (short *)malloc(pcmSize);
    int numSamples = 0;
    NSMutableData *soundTouchData = [[NSMutableData alloc] init];
    do {
        memset(samples, 0, pcmSize);
        numSamples = mSoundTouch.receiveSamples(samples, pcmSize);
        [soundTouchData appendBytes:samples length:numSamples*sizeof(short)];
    } while (numSamples > 0);
    NSMutableData *outWavData = [[NSMutableData alloc] init];
    void *header = createWaveHeader((int)soundTouchData.length, 1, 8000, 16);
    [outWavData appendBytes:header length:44];
    [outWavData appendData:soundTouchData];
    
    NSString *outPath = [docPath stringByAppendingPathComponent:@"2.wav"];
    [outWavData writeToFile:outPath atomically:YES];
    
    free(samples);
    free(header);
}

- (IBAction)handleWavButtonClick:(id)sender {
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docPath stringByAppendingPathComponent:@"2.wav"];
    
    wavPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:path] error:nil];
    wavPlayer.delegate = self;
    [wavPlayer prepareToPlay];
    [wavPlayer play];
    NSLog(@"duration %.2f", wavPlayer.duration);
    
    [self.wavPlayBtn setTitle:@"..." forState:UIControlStateNormal];
}

- (IBAction)handleImageFilterClick:(id)sender {
    TXImageFilterViewController *imageFilterVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageFilterVC"];
    [self presentViewController:imageFilterVC animated:YES completion:^{
        
    }];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"play finished");
    [self.wavPlayBtn setTitle:@"播放" forState:UIControlStateNormal];
}

void *createWaveHeader(int fileLength, short channel, int sampleRate, short bitPerSample)
{
    
    struct wave_header *header = (struct wave_header *)malloc(sizeof(struct wave_header));
    
    if (header == NULL) {
        return  NULL;
    }
    
    // RIFF
    header->riff[0] = 'R';
    header->riff[1] = 'I';
    header->riff[2] = 'F';
    header->riff[3] = 'F';
    
    // file length
    header->fileLength = fileLength + (44 - 8);
    
    // WAVE
    header->wavTag[0] = 'W';
    header->wavTag[1] = 'A';
    header->wavTag[2] = 'V';
    header->wavTag[3] = 'E';
    
    // fmt
    header->fmt[0] = 'f';
    header->fmt[1] = 'm';
    header->fmt[2] = 't';
    header->fmt[3] = ' ';
    
    header->size = 16;
    header->formatTag = 1;
    header->channel = channel;
    header->sampleRate = sampleRate;
    header->bitPerSample = bitPerSample;
    header->blockAlign = (short)(header->channel * header->bitPerSample / 8);
    header->bytePerSec = header->blockAlign * header->sampleRate;
    
    // data
    header->data[0] = 'd';
    header->data[1] = 'a';
    header->data[2] = 't';
    header->data[3] = 'a';
    
    // data size
    header->dataSize = fileLength;
    
    return header;
}

@end
