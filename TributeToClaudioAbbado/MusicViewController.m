//
//  MusicViewController.m
//  TributeToClaudioAbbado
//
//  Created by SDT-1 on 2014. 1. 22..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "MusicViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MusicViewController () <AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *songName;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;

@end

@implementation MusicViewController{
    AVAudioPlayer *player;
    NSTimer *timer;
    NSArray *musicFiles;
}

- (void)updateProgress:(NSTimer *)timer{
    self.progress.progress = player.currentTime / player.duration;
}

- (void)playMusic:(NSURL *)url{
    if (nil != player) {
        if ([player isPlaying]) {
            [player stop];
        }
        player = nil;
        
        [timer invalidate];
        timer = nil;
    }
    __autoreleasing NSError *error;
    player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    player.delegate = self;
    
    if ([player prepareToPlay]) {
        self.songName.text = [NSString stringWithFormat:@"%@", [[url path]lastPathComponent]];
        [player play];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
        
    }
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
    self.songName.text = [NSString stringWithFormat:@"재생중 오류 발생 : %@", [error description]];
    
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    self.songName.text = @"재생 완료";
    
    [timer invalidate];
    timer = nil;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
   // musicFiles = [[NSArray alloc]initWithObjects:@"music1.mp3", @"music2.mp3", @"music3.mp3", nil];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.titleImage.image = self.title2;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    __autoreleasing NSError *error = nil;
    [session setCategory:AVAudioSessionCategoryAmbient error:&error];
 
    NSString *fileName = self.name;
    NSURL *urlForPlay = [[NSBundle mainBundle]URLForResource:fileName withExtension:nil];
    [self playMusic:urlForPlay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
