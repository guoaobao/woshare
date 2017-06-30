//
//  GeeMoviePlayerViewController.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/7/1.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeMoviePlayerViewController.h"
//#include "ffmpeg.h"
#import <MediaPlayer/MediaPlayer.h>
#import "KxMovieViewController.h"
@interface GeeMoviePlayerViewController ()

@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;//视频播放控制器

@end

@implementation GeeMoviePlayerViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    NSString *path = self.playUrl;
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"FFmpegTest.yuv" ofType:nil];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    // increase buffering for .wmv, it solves problem with delaying audio frames
    if ([path.pathExtension isEqualToString:@"wmv"])
        parameters[KxMovieParameterMinBufferedDuration] = @(5.0);
    
    // disable deinterlacing for iPhone, because it's complex operation can cause stuttering
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        parameters[KxMovieParameterDisableDeinterlacing] = @(YES);
    
    KxMovieViewController *vc = [KxMovieViewController movieViewControllerWithContentPath:path
                                                                               parameters:parameters];
    [self presentViewController:vc animated:YES completion:nil];
    
    
//    [self setupViewOfController];
}


- (void)setupViewOfController
{     //添加通知
      [self addNotification];
    //播放
    [self.moviePlayer play];
    [self showIndicator];
    
//    //添加通知
//    [self addNotification];
    
    UIButton *back = [[UIButton alloc]init];
    [back setImage:[UIImage imageNamed:@"hs_last_backpic"] forState:UIControlStateNormal];
    back.frame = CGRectMake(20, 25, 46, 34);
    [self.view addSubview:back];
    [back addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)backButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.moviePlayer stop];
}

//- (NSString *)changeToMp4:(NSString *)path
//{
//    NSString *outputpath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"gab.mp4"];
//    
////    outputpath = [@"file://" stringByAppendingString:outputpath];
//    BOOL isexist = [[NSFileManager defaultManager] fileExistsAtPath:outputpath];
//    if (isexist) {
//        [[NSFileManager defaultManager] removeItemAtPath:outputpath error:nil];
//    }
//    //        NSString *command_str = [NSString stringWithFormat:@"ffmpeg -i %@ -b:v 400k -s 480x640 %@",path,outputpath];
//    
//    NSString *command_str = [NSString stringWithFormat:@"ffmpeg -i %@ -acodec copy -vcodec copy %@",path,outputpath];
//    
//    NSArray *argv_array=[command_str componentsSeparatedByString:(@" ")];
//    int argc=(int)argv_array.count;
//    char** argv=(char**)malloc(sizeof(char*)*argc);
//    for(int i=0;i<argc;i++)
//    {
//        argv[i]=(char*)malloc(sizeof(char)*1024);
//        strcpy(argv[i],[[argv_array objectAtIndex:i] UTF8String]);
//    }
//    
//    ffmpegmain(argc, argv);
//    
//    for(int i=0;i<argc;i++)
//        free(argv[i]);
//    free(argv);
//    
//    return outputpath;
//}

/**
 *  创建媒体播放控制器
 *
 *  @return 媒体播放控制器
 */
-(MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
        NSURL *url=[NSURL URLWithString:self.playUrl];
//        NSString *gaburl=[self changeToMp4:url.absoluteString];
        _moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:url];
        _moviePlayer.view.frame=self.view.bounds;
        _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        _moviePlayer.movieSourceType=MPMovieSourceTypeStreaming;
//        [_moviePlayer prepareToPlay];
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}

/**
 *  添加通知监控媒体播放控制器状态
 */
-(void)addNotification{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    
}

/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            [self hideIndicator];
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",self.moviePlayer.playbackState);
            break;
    }
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    NSLog(@"播放完成.%li",self.moviePlayer.playbackState);
}


- (void)dealloc
{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    [notificationCenter removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    NSLog(@"释放");
}

@end
