//
//  EasterEggViewController.m
//  Holocron
//
//  Created by Mike Henry on 10/14/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

#import "ViewController.h"
#import "EasterEggViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface EasterEggViewController ()

@property (readwrite, retain) AVPlayer *audioPlayer1;

@end

@implementation EasterEggViewController

#pragma mark Interactivity Methods

-(void)playerItemDidReachEnd:(NSNotification *)notification {
    NSLog(@"Item Ended");
    AVPlayerItem *item = [notification object];
    if (item == _audioPlayer1.currentItem) {
        [_audioPlayer1.currentItem seekToTime:kCMTimeZero];
        [self audio1PlayButtonPressed:self];
    }
}

- (IBAction)audio1PlayButtonPressed:(id)sender {
        [_audioPlayer1 play];
}


#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // need to loop through an array and input the url for the audio files
    NSURL *cheweyURL = [[NSBundle mainBundle] URLForResource:@"replace" withExtension:@"mp3"];
    _audioPlayer1 = [AVPlayer playerWithURL:cheweyURL];
    _audioPlayer1.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:[_audioPlayer1 currentItem]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
