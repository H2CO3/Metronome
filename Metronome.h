//
// Metronome.h
// Metronome
//
// Created by H2CO3 on 04/03/2012
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface Metronome: NSObject {
  UIWindow *window;
  UISlider *speedControl;
  UISlider *volume;
  UILabel *speedLabel;
  UILabel *pauseLabel;
  AVAudioPlayer *tickPlayer;
  NSTimer *timer;
}

@property (nonatomic, retain) UIWindow *window;

- (void)start;
- (void)stop;
- (void)changeBeat;

@end
