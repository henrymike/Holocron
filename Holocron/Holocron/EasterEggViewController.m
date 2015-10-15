//
//  EasterEggViewController.m
//  Holocron
//
//  Created by Mike Henry on 10/14/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

#import "ViewController.h"
#import "EasterEggViewController.h"


@interface EasterEggViewController ()

@property (readwrite, retain) AVPlayer *audioPlayer1;
@property (readwrite, retain) AVPlayer *audioPlayer2;
@property (readwrite, retain) AVPlayer *audioPlayer3;
@property (readwrite, retain) AVPlayer *audioPlayer4;
@property (readwrite, retain) AVPlayer *audioPlayer5;
@property (readwrite, retain) AVPlayer *audioPlayer6;
@property (readwrite, retain) AVPlayer *audioPlayer7;
@property (readwrite, retain) AVPlayer *audioPlayer8;

@end

@implementation EasterEggViewController

#pragma mark Interactivity Methods

//-(void)playerItemDidReachEnd:(NSNotification *)notification {
//    NSLog(@"Item Ended");
//    AVPlayerItem *item = [notification object];
//    if (item == _audioPlayer1.currentItem) {
//        [_audioPlayer1.currentItem seekToTime:kCMTimeZero];
//        [_audioPlayer1 pause];
//    }
//}
//
//- (IBAction)audio1PlayButtonPressed:(id)sender {
//        [_audioPlayer1 play];
//}

- (IBAction)button1Pressed:(id)sender {
    NSURL *audio1 = [[NSBundle mainBundle] URLForResource:@"ChewbaccaSound1" withExtension:@"mp3"];
    _audioPlayer1 = [AVPlayer playerWithURL:audio1];
    [_audioPlayer1.self play];
}

- (IBAction)button2Pressed:(id)sender {
    NSURL *audio2 = [[NSBundle mainBundle] URLForResource:@"ChewbaccaSound2" withExtension:@"mp3"];
    _audioPlayer2 = [AVPlayer playerWithURL:audio2];
    [_audioPlayer2.self play];
}

- (IBAction)button3Pressed:(id)sender {
    NSURL *audio3 = [[NSBundle mainBundle] URLForResource:@"ChewbaccaSound3" withExtension:@"mp3"];
    _audioPlayer3 = [AVPlayer playerWithURL:audio3];
    [_audioPlayer3.self play];
}

- (IBAction)button4Pressed:(id)sender {
    NSURL *audio4 = [[NSBundle mainBundle] URLForResource:@"ChewbaccaSound4" withExtension:@"mp3"];
    _audioPlayer4 = [AVPlayer playerWithURL:audio4];
    [_audioPlayer4.self play];
}

- (IBAction)button5Pressed:(id)sender {
    NSURL *audio5 = [[NSBundle mainBundle] URLForResource:@"ChewbaccaSound5" withExtension:@"mp3"];
    _audioPlayer5 = [AVPlayer playerWithURL:audio5];
    [_audioPlayer5.self play];
}

- (IBAction)button6Pressed:(id)sender {
    NSURL *audio6 = [[NSBundle mainBundle] URLForResource:@"ChewbaccaSound6" withExtension:@"mp3"];
    _audioPlayer6 = [AVPlayer playerWithURL:audio6];
    [_audioPlayer6.self play];
}

- (IBAction)button7Pressed:(id)sender {
    NSURL *audio7 = [[NSBundle mainBundle] URLForResource:@"ChewbaccaSound7" withExtension:@"mp3"];
    _audioPlayer7 = [AVPlayer playerWithURL:audio7];
    [_audioPlayer7.self play];
}

- (IBAction)button8Pressed:(id)sender {
    NSURL *audio8 = [[NSBundle mainBundle] URLForResource:@"ChewbaccaSound8" withExtension:@"mp3"];
    _audioPlayer8 = [AVPlayer playerWithURL:audio8];
    [_audioPlayer8.self play];
}


#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // need to loop through an array and input the url for the audio files
//    NSURL *cheweyURL = [[NSBundle mainBundle] URLForResource:@"ChewbaccaSound1" withExtension:@"mp3"];
//    _audioPlayer1 = [AVPlayer playerWithURL:cheweyURL];
//    _audioPlayer1.actionAtItemEnd = AVPlayerActionAtItemEndNone;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:[_audioPlayer1 currentItem]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
