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
#import "TXImagePickerController.h"
#import "TXScrollImageViewController.h"
#import "TXCameraOverlayViewController.h"
#import "YCameraViewController.h"
#import "TXVisionViewController.h"
#import "TXVideoViewController.h"
#import "TXBgImageViewController.h"
#import "TXMapViewController.h"
#import "TXStatusBarViewController.h"
#import "TXJumpAppStoreViewController.h"
#import "TXMAMapViewController.h"
#import "TXRichTextViewController.h"
#import "TXDrawViewController.h"
#import "TXReuseViewController.h"
#import "TXSystemCategory.h"
#import "TXAlViewController.h"
#import "TXSocketViewController.h"

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
    
////    CGRect frame = CGRectMake(13, 20, 38, 30);
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
////    backButton.frame = frame;
//    [backButton setTitle:@"返回" forState:UIControlStateNormal];
//    [backButton addTarget:self action:@selector(handleBackButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:backButton];
    
    //  1
//    [backButton setTranslatesAutoresizingMaskIntoConstraints:NO];
//    NSMutableArray *tempConstraints = [NSMutableArray array];
//    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[backButton(==38)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(backButton)]];
//    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[backButton(==30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(backButton)]];
//    [self.view addConstraints:tempConstraints];
    
    //  2
//    NSLayoutConstraint *topConst = [NSLayoutConstraint constraintWithItem:backButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:20];
//    NSLayoutConstraint *leftConst = [NSLayoutConstraint constraintWithItem:backButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10];
//    NSLayoutConstraint *widthConst = [NSLayoutConstraint constraintWithItem:backButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0/8.0 constant:0];
//    NSLayoutConstraint *heightConst = [NSLayoutConstraint constraintWithItem:backButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0/15.0 constant:0];
//    [tempConstraints addObject:topConst];
//    [tempConstraints addObject:leftConst];
//    [tempConstraints addObject:widthConst];
//    [tempConstraints addObject:heightConst];
//    [self.view addConstraints:tempConstraints];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    NSLog(@"source %@", segue.sourceViewController);
//    NSLog(@"dest %@", segue.destinationViewController);
//    NSLog(@"sender %@", sender);
}

- (void)setupBackButton
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(handleBackButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    [backButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSMutableArray *tempConstraints = [NSMutableArray array];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[backButton(==38)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(backButton)]];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[backButton(==30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(backButton)]];
    [self.view addConstraints:tempConstraints];
}

- (void)handleBackButtonClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)handleRecordButtonClick:(id)sender {
    if (recorder == nil) {
        recorder = [[TXAMRRecorder alloc] init];
    }
    
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
    if (player == nil) {
        player = [[TXAMRPlayer alloc] init];
        player.delegate = self;
    }
    
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
        
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
        AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute, sizeof(audioRouteOverride), &audioRouteOverride);
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
   
#define BUFFER_SIZE2 1024
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docPath stringByAppendingPathComponent:@"1.wav"];
    NSData *wavData = [[NSData alloc] initWithContentsOfFile:path];
    short *pcmData = (short *)wavData.bytes;
    int pcmSize = (int)wavData.length;
    int nSamples = pcmSize / sizeof(short);
    mSoundTouch.putSamples(pcmData, nSamples);
    int numSamples = 0;
    NSMutableData *soundTouchData = [[NSMutableData alloc] init];
    do {
        short sampleBuffer[BUFFER_SIZE2];
        numSamples = mSoundTouch.receiveSamples(sampleBuffer, BUFFER_SIZE2);
        [soundTouchData appendBytes:sampleBuffer length:numSamples*sizeof(short)];
    } while (numSamples > 0);
    NSMutableData *outWavData = [[NSMutableData alloc] init];
    void *header = createWaveHeader((int)soundTouchData.length, 1, 8000, 16);
    [outWavData appendBytes:header length:44];
    [outWavData appendData:soundTouchData];
    
    NSString *outPath = [docPath stringByAppendingPathComponent:@"2.wav"];
    [outWavData writeToFile:outPath atomically:YES];
    
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

- (IBAction)handleCameraButtonClick:(id)sender {
    TXImagePickerController *picker = [[TXImagePickerController alloc] initWithDelegate:self];
//    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    NSLog(@"%@", viewController);
////    for (UIView *subview in [viewController.view subviews]) {
////        NSLog(@"%@", subview);
////    }
//    
//    UIView *PLCameraView = [self findView:viewController.view withName:@"PLCameraView"];
//    NSLog(@"%@", PLCameraView);
////    UIView *PLCropOverlay = [self findView:PLCameraView withName:@"PLCropOverlay"];
////    NSLog(@"%@", PLCropOverlay);
//    UIView *bottomBar=[self findView:PLCameraView withName:@"PLCropOverlayBottomBar"];
//    NSLog(@"%@", bottomBar);
////    UIView *TPBottomDualButtonBar = [self findView:PLCropOverlay withName:@"TPBottomDualButtonBar"];
////    NSLog(@"%@", TPBottomDualButtonBar);
////    UIView *TPPushButton = [self findView:bottomBar withName:@"TPPushButton"];
////    NSLog(@"%@", TPPushButton);
//    //Get ImageView For Camera
//    UIImageView *bottomBarImageForCamera = [bottomBar.subviews objectAtIndex:1];
//    NSLog(@"%@", bottomBarImageForCamera);
//    //Get Button 0(The Capture Button)
//    UIButton *cameraButton=[bottomBarImageForCamera.subviews objectAtIndex:0];
//    NSLog(@"%@", cameraButton);
//    //Get Button 1
//    UIButton *cancelButton=[bottomBarImageForCamera.subviews objectAtIndex:1];
//    NSLog(@"%@", cancelButton);
//    CGRect frame = cancelButton.frame;
//    CGRect rect = frame;
//    frame.origin.x = bottomBarImageForCamera.frame.size.width - 6 - frame.size.width;
//    cancelButton.frame = frame;
//    
//    UIButton *pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    pickButton.frame = rect;
//    [pickButton addTarget:self action:@selector(handlePickLocalClick:) forControlEvents:UIControlEventTouchUpInside];
//    [bottomBarImageForCamera addSubview:pickButton];
//}

- (void)handlePickLocalClick:(id)sender
{
    TXImagePickerController *picker = [[TXImagePickerController alloc] init];
    picker.pickerDelegate = self;
//    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (UIView *)findView:(UIView *)aView withName:(NSString *)name
{
    Class cls = [aView class];
    NSString *desc = [cls description];
    
    if ([name isEqualToString:desc]) {
        return aView;
    }
    
    for (NSUInteger i = 0; i < [aView.subviews count]; i++) {
        UIView *subView = [aView.subviews objectAtIndex:i];
        subView = [self findView:subView withName:name];
        if (subView) {
            return subView;
        }
    }
    
    return nil;
}

- (IBAction)handleScrollButtonClick:(id)sender {
    TXScrollImageViewController *scrollImageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"scrollImageVC"];
    [self presentViewController:scrollImageVC animated:YES completion:^{
        
    }];
}

- (IBAction)handleCaptureButtonClick:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.allowsEditing = YES;
//    picker.showsCameraControls = NO;
    picker.wantsFullScreenLayout = YES;
    TXCameraOverlayViewController *overlayVC = [self.storyboard instantiateViewControllerWithIdentifier:@"cameraOverlayViewController"];
    picker.cameraOverlayView = overlayVC.view;
    overlayVC.pickerController = picker;
    [self presentViewController:picker animated:YES completion:nil];
}
- (IBAction)handleYCameraButtonClick:(id)sender {
    YCameraViewController *cameraVC = [self.storyboard instantiateViewControllerWithIdentifier:@"yCameraViewController"];
    cameraVC.delegate = self;
    [self presentViewController:cameraVC animated:YES completion:nil];
}

- (IBAction)handleVisionButtonClick:(id)sender {
    TXVisionViewController *visionController = [self.storyboard instantiateViewControllerWithIdentifier:@"visionViewController"];
    [self presentViewController:visionController animated:YES completion:nil];
}

- (IBAction)handleBackgroundPicButtonClick:(id)sender {
    TXBgImageViewController *bgImageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"bgImageViewController"];
    [self presentViewController:bgImageVC animated:YES completion:nil];
}

- (IBAction)handleMapButtonClick:(id)sender {
    TXMapViewController *mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"mapViewController"];
    [self presentViewController:mapVC animated:YES completion:nil];
}

- (IBAction)handleTipButtonClick:(id)sender {
    UINavigationController *navController = [self.storyboard instantiateViewControllerWithIdentifier:@"statusBarNavController"];
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - YCameraViewController Delegate
- (void)didFinishPickingImage:(UIImage *)image{
    NSLog(@"YCamera %@", image);
}

- (void)yCameraControllerdidSkipped{
    
}

- (void)yCameraControllerDidCancel{
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSLog(@"%@", image);
    [picker dismissViewControllerAnimated:YES completion:nil];
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

- (IBAction)handleViewButtonClick:(id)sender {
    TXVideoViewController *videoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"videoViewController"];
    [self presentViewController:videoVC animated:YES completion:nil];
}

- (IBAction)handleStoreButtonClick:(id)sender {
    TXJumpAppStoreViewController *jumpStoreVC = [self.storyboard instantiateViewControllerWithIdentifier:@"jumpAppStoreViewController"];
    [self presentViewController:jumpStoreVC animated:YES completion:nil];
}

- (IBAction)handleGaodeButtonClick:(id)sender {
    TXMapViewController *maMapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"maMapViewController"];
    [self presentViewController:maMapVC animated:YES completion:nil];
}

- (IBAction)handleFaceButtonClick:(id)sender {
    TXRichTextViewController *richTextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"richTextViewController"];
    [self presentViewController:richTextVC animated:YES completion:nil];
}

- (IBAction)handleDrawButtonClick:(id)sender {
    TXDrawViewController *drawVC = [self.storyboard instantiateViewControllerWithIdentifier:@"drawViewController"];
    [self presentViewController:drawVC animated:YES completion:nil];
}

- (IBAction)handleReuseButtonClick:(id)sender {
    TXReuseViewController *reuseVC = [self.storyboard instantiateViewControllerWithIdentifier:@"reuseViewController"];
    [self presentViewController:reuseVC animated:YES completion:nil];
}

- (IBAction)handleDecrytButtonClick:(id)sender {
    NSString *testString = @"LBCg8jYCbyVTXhXjATJJzo1n8iEomQ5419+noV+9NqrMeI8PkiY54WBljIvCX8pW";
    NSString *key = @"9gMh1lNQnE9B6nJy";
    NSData *testData = [testString dataUsingEncoding:NSUTF8StringEncoding];
    NSData *destData = [testData DecryptDataWithKey:key];
    char *bytes = (char *)malloc(destData.length+1);
    [destData getBytes:bytes length:destData.length];
    for (int i = 0; i < destData.length; i++) {
        printf("%d,", bytes[i]);
    }
    printf("\n");
    NSString *destString = [[NSString alloc] initWithData:destData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", destString);
    free(bytes);
}

- (IBAction)handleAtButtonClick:(id)sender {
    TXAlViewController *alVC = [self.storyboard instantiateViewControllerWithIdentifier:@"alViewController"];
    [self presentViewController:alVC animated:YES completion:nil];
}

- (IBAction)handleChatButtonClick:(id)sender {
    TXSocketViewController *socketVC = [self.storyboard instantiateViewControllerWithIdentifier:@"socketViewController"];
    [self presentViewController:socketVC animated:YES completion:nil];
}

@end
