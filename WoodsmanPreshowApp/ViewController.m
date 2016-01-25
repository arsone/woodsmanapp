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
    void *fadeVolume;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [NSString stringWithFormat:@"%@/main_v2.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    audioPlayer.delegate = self;
    
    [audioPlayer setVolume:1.0];
    [audioPlayer setNumberOfLoops:-1];
    
    NSString *announcePath = [NSString stringWithFormat:@"%@/preshow_announce.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *announceUrl = [NSURL fileURLWithPath:announcePath];
    
    announcementPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:announceUrl error:nil];
    announcementPlayer.delegate = self;
    
    [announcementPlayer setVolume:1.0];

}

- (void)fadeVolumeDown {
    if(self->audioPlayer.volume > 0.1) {
        self->audioPlayer.volume = self->audioPlayer.volume - 0.1;
        [self performSelector:@selector(fadeVolumeDown) withObject:nil afterDelay:0.1];
    }
}

- (void)fadeVolumeUp {
    if(self->audioPlayer.volume < 1.0) {
        self->audioPlayer.volume = self->audioPlayer.volume + 0.1;
        [self performSelector:@selector(fadeVolumeUp) withObject:nil afterDelay:0.1];
    }
}

- (void)fadeVolumeOut {
    if(self->audioPlayer.volume > 0.1) {
        self->audioPlayer.volume = self->audioPlayer.volume - 0.1;
        [self performSelector:@selector(fadeVolumeOut) withObject:nil afterDelay:0.1];
    } else {
        [self->audioPlayer stop];
        audioPlayer.currentTime = 0;
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)announcementPlayer successfully:(BOOL)flag {
    if(flag == YES && audioPlayer.volume < 1.0) {
        audioPlayer.volume = audioPlayer.volume + 0.1;
        [self performSelector:@selector(fadeVolumeUp) withObject:nil afterDelay:0.1];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playPreshow:(id)sender {
    [audioPlayer play];
}

- (IBAction)playAnnounce:(id)sender {
    if (audioPlayer.volume > 0.6) {
        audioPlayer.volume = audioPlayer.volume - 0.1;
        [self performSelector:@selector(fadeVolumeDown) withObject:nil afterDelay:0.1];
    }
    [announcementPlayer play];
    [self performSelector:@selector(audioPlayerDidFinishPlaying:successfully:) withObject:nil afterDelay:0.1];
}

- (IBAction)stopPreshow:(id)sender {
    if (audioPlayer.volume > 0.0) {
        audioPlayer.volume = audioPlayer.volume - 0.1;
        [self performSelector:@selector(fadeVolumeOut) withObject:nil afterDelay:0.1];
    }
    [announcementPlayer stop];
    announcementPlayer.currentTime = 0;
}

@end
