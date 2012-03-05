//
// Metronome.m
// Metronome
//
// Created by H2CO3 on 04/03/2012
//

#import "Metronome.h"

#define RES_URL(f) [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:(f) ofType:NULL]]

@implementation Metronome

@synthesize window = window;

- (id)init
{
  if ((self = [super init]))
  {
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    [window makeKeyAndVisible];

    UILabel *speedControlLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 144, 280, 29)];
    speedControlLabel.textAlignment = UITextAlignmentCenter;
    speedControlLabel.backgroundColor= [UIColor clearColor];
    speedControlLabel.textColor = [UIColor whiteColor];
    speedControlLabel.font = [UIFont boldSystemFontOfSize:14.0];
    speedControlLabel.text = @"Beat (1/min)";
    [window addSubview:speedControlLabel];
    [speedControlLabel release];

    speedControl = [[UISlider alloc] initWithFrame:CGRectMake(20, 180, 280, 29)];
    speedControl.minimumValue = 30.0;
    speedControl.maximumValue = 180.0;
    speedControl.value = 60.0;
    [speedControl addTarget:self action:@selector(changeBeat) forControlEvents:UIControlEventValueChanged];
    [window addSubview:speedControl];
    [speedControl release];

    UILabel *volumeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 280, 29)];
    volumeLabel.textAlignment = UITextAlignmentCenter;
    volumeLabel.backgroundColor = [UIColor clearColor];
    volumeLabel.textColor = [UIColor whiteColor];
    volumeLabel.font = [UIFont boldSystemFontOfSize:14.0];
    volumeLabel.text = @"Volume";
    [window addSubview:volumeLabel];
    [volumeLabel release];

    volume = [[UISlider alloc] initWithFrame:CGRectMake(20, 350, 280, 29)];
    volume.value = 0.5;
    [volume addTarget:self action:@selector(changeVolume) forControlEvents:UIControlEventValueChanged];
    [window addSubview:volume];
    [volume release];

    speedLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 64)];
    speedLabel.font = [UIFont boldSystemFontOfSize:72.0];
    speedLabel.backgroundColor = [UIColor clearColor];
    speedLabel.textColor = [UIColor whiteColor];
    speedLabel.text = @"60/min";
    speedLabel.textAlignment = UITextAlignmentCenter;
    [window addSubview:speedLabel];
    [speedLabel release];

    pauseLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 280, 29)];
    pauseLabel.font = [UIFont boldSystemFontOfSize:14.0];
    pauseLabel.textAlignment = UITextAlignmentCenter;
    pauseLabel.backgroundColor = [UIColor clearColor];
    pauseLabel.textColor = [UIColor whiteColor];
    [window addSubview:pauseLabel];
    [pauseLabel release];

    UIImage *buttonImageUnstrechable = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"button" ofType:@"png"]];
    UIImage *buttonImage = [buttonImageUnstrechable stretchableImageWithLeftCapWidth:4.0 topCapHeight:0.0];
    [buttonImageUnstrechable release];

    UIButton *start = [UIButton buttonWithType:UIButtonTypeCustom];
    start.frame = CGRectMake(20, 400, 130, 44);
    start.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    [start setTitle:@"Start" forState:UIControlStateNormal];
    [start setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [start addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:start];

    UIButton *stop = [UIButton buttonWithType:UIButtonTypeCustom];
    stop.frame = CGRectMake(170, 400, 130, 44);
    stop.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    [stop setTitle:@"Stop" forState:UIControlStateNormal];
    [stop setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [stop addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:stop];

    tickPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:RES_URL(@"tick.caf") error:NULL];
    tickPlayer.volume = 0.5;
    [self start];
  }

  return self;
}

- (void)dealloc
{
  [timer invalidate];
  [tickPlayer release];
  [super dealloc];
}

- (void)changeBeat
{
  speedLabel.text = [NSString stringWithFormat:@"%d/min", (int)(speedControl.value + 0.5)];
  [self start];
}

- (void)start
{
  pauseLabel.text = NULL;
  [timer invalidate];
  timer = [NSTimer scheduledTimerWithTimeInterval:60.0 / speedControl.value target:tickPlayer selector:@selector(play) userInfo:NULL repeats:YES];
}

- (void)stop
{
  pauseLabel.text = @"Paused";
  [timer invalidate];
  timer = NULL;
}

- (void)changeVolume
{
  tickPlayer.volume = volume.value;
}

@end
