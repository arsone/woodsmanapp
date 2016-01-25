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
    AVAudioPlayer *_audioPlayer;
    AVAudioPlayer *_announcementPlayer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [NSString stringWithFormat:@"%@/main_v2.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
    NSString *announcePath = [NSString stringWithFormat:@"%@/preshow_announce.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *announceUrl = [NSURL fileURLWithPath:announcePath];
    
    _announcementPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:announceUrl error:nil];
}

//- (void)fadeVolume:(AVAudioPlayer*)player fromVolume:(float)startVolume
//          toVolume:(float)endVolume overTime:(float)time {
//    
//    float fadeSteps = time * 100.0;
//    
//    self->_audioPlayer.volume = startVolume;
//    
//    for (int step = 0; step < fadeSteps; step++) {
//        double delayInSeconds = step * (time / fadeSteps);
//        
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t) (delayInSeconds * NSEC_PER_SEC));
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            float fraction = ((float)step / fadeSteps);
//            
//            self->_audioPlayer.volume = startVolume + (endVolume - startVolume)* fraction;
//        });
//    }
//}

//-(void) fadeOut {
//    if (self->_audioPlayer.volume <= 0.0f) return;
//    else {
//        self->_audioPlayer.volume -=0.1;
//        __weak typeof (self) weakSelf = self;
//        [NSThread sleepForTimeInterval:0.2f];
//        [self.fadingQueue addOperationWithBlock:^{
//            NSLog(@"fading out %.2f", self->_audioPlayer.volume);
//            [weakSelf fadeOut];
//        }];
//    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playPreshow:(id)sender {
    [_audioPlayer setNumberOfLoops:-1];
    [_audioPlayer play];
}

- (IBAction)playAnnounce:(id)sender {
    [_announcementPlayer play];
}

- (IBAction)stopPreshow:(id)sender {
    [_audioPlayer stop];
    [_announcementPlayer stop];
    
}

@end
