//
//  ViewController.m
//  WoodsmanPreshowApp
//
//  Created by Adam Salberg on 1/24/16.
//  Copyright © 2016 Adam Salberg. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
{
    AVAudioPlayer *audioPlayer;
    AVAudioPlayer *announcementPlayer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [NSString stringWithFormat:@"%@/main_v2.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    audioPlayer.delegate = self;
    
    [audioPlayer setNumberOfLoops:-1];
    
    NSString *announcePath = [NSString stringWithFormat:@"%@/preshow_announce.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *announceUrl = [NSURL fileURLWithPath:announcePath];
    
    announcementPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:announceUrl error:nil];
    announcementPlayer.delegate = self;

}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"audioPlayerDidFinishPlaying");
}

//- (void)fadeDown:(AVAudioPlayer *)_audioPlayer {
//    _audioPlayer.volume = _audioPlayer.volume - 0.1;
//    if (_audioPlayer.volume < 0.1) {
//        [_audioPlayer stop];
//    } else {
//        [self performSelector:@selector(fadeDown:) withObject:_audioPlayer afterDelay:0.1];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playPreshow:(id)sender {
    [audioPlayer play];
}

- (IBAction)playAnnounce:(id)sender {
    [announcementPlayer play];
}

- (IBAction)stopPreshow:(id)sender {
    [audioPlayer stop];
    audioPlayer.currentTime = 0;
    [announcementPlayer stop];
    announcementPlayer.currentTime = 0;
}

@end
