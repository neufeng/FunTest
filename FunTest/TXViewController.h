//
//  TXViewController.h
//  FunTest
//
//  Created by Steven Cheung on 6/17/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXAMRRecorder.h"
#import "TXAMRPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface TXViewController : UIViewController<AVAudioRecorderDelegate, AVAudioPlayerDelegate> {
    TXAMRPlayer *player;
    TXAMRRecorder *recorder;
    
    AVAudioRecorder *wavRecorder;
    AVAudioPlayer *wavPlayer;
}
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutlet UIButton *recordBtn;
@property (strong, nonatomic) IBOutlet UIButton *playBtn;

- (IBAction)handleRecordButtonClick:(id)sender;
- (IBAction)handlePlayButtonClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *recordWavBtn;
@property (strong, nonatomic) IBOutlet UIButton *changeVoice;
@property (strong, nonatomic) IBOutlet UIButton *wavPlayBtn;

- (IBAction)handleRecordWavButtonClick:(id)sender;
- (IBAction)handleChangeVoiceButtonClick:(id)sender;
- (IBAction)handleWavButtonClick:(id)sender;
- (IBAction)handleImageFilterClick:(id)sender;

// wav头部结构体
struct wave_header {
    
    char riff[4];
    unsigned long fileLength;
    char wavTag[4];
    char fmt[4];
    unsigned long size;
    unsigned short formatTag;
    unsigned short channel;
    unsigned long sampleRate;
    unsigned long bytePerSec;
    unsigned short blockAlign;
    unsigned short bitPerSample;
    char data[4];
    unsigned long dataSize;
    
};

@end
