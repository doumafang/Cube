//
//  PlayerViewController.m
//  Cube
//
//  Created by doumaaaaaaaa on 16/4/11.
//  Copyright © 2016年 doumafang. All rights reserved.
//

#import "PlayerViewController.h"

@implementation PlayerViewController
{
    UIView* _AllBackGroudView;

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.view.clipsToBounds = YES;
    [self RtmpInit];
      
}

-(void) RtmpInit{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
        view.backgroundColor = [UIColor redColor];
        [self.view addSubview:view];
        [[LiveVideoCoreSDK sharedinstance] LiveInit:self.rtmpURL Preview:view VideSize:LIVE_VIEDO_SIZE_D1 BitRate:LIVE_BITRATE_500Kbps FrameRate:LIVE_FRAMERATE_15];
        [LiveVideoCoreSDK sharedinstance].delegate = self;
        [[LiveVideoCoreSDK sharedinstance] setCameraFront:YES];
//        [[LiveVideoCoreSDK sharedinstance] setFilter:LIVE_FILTER_BLACK];
        [[LiveVideoCoreSDK sharedinstance] connect];
        [LiveVideoCoreSDK sharedinstance].micGain = 0;

    });
}

- (void) viewWillAppear:(BOOL)animated{
    NSLog(@"CameraViewController: viewWillAppear");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WillResignActiveNotification) name:UIApplicationWillResignActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WillDidBecomeActiveNotification) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForegroundNotification) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [super viewDidAppear:YES];
}

- (void) appWillEnterForegroundNotification{
    NSLog(@"trigger event when will enter foreground.");
    if (![self hasPermissionOfCamera]) {
        return;
    }
    [self RtmpInit];
    
}
- (void)WillDidBecomeActiveNotification{
    NSLog(@"CameraViewController: WillDidBecomeActiveNotification");
    
}

- (void)WillResignActiveNotification{
    NSLog(@"LiveShowViewController: WillResignActiveNotification");
    
    if (![self hasPermissionOfCamera]) {
        return;
    }
    //得到当前应用程序的UIApplication对象
    UIApplication *app = [UIApplication sharedApplication];
    
    //一个后台任务标识符
    UIBackgroundTaskIdentifier taskID;
    taskID = [app beginBackgroundTaskWithExpirationHandler:^{
        //如果系统觉得我们还是运行了太久，将执行这个程序块，并停止运行应用程序
        [app endBackgroundTask:taskID];
    }];
    //UIBackgroundTaskInvalid表示系统没有为我们提供额外的时候
    if (taskID == UIBackgroundTaskInvalid) {
        NSLog(@"Failed to start background task!");
        return;
    }
    
    //[[SCCaptureManager sharedManager] disconnect];
    [[LiveVideoCoreSDK sharedinstance] disconnect];
    [[LiveVideoCoreSDK sharedinstance] LiveRelease];
    
    //告诉系统我们完成了
    [app endBackgroundTask:taskID];
}


- (BOOL)hasPermissionOfCamera
{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus != AVAuthorizationStatusAuthorized){
        
        NSLog(@"相机权限受限");
        return NO;
    }
    return YES;
}
-(void) viewDidDisappear:(BOOL)animated{
    NSLog(@"CameraViewController: viewDidDisappear");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];//删除去激活界面的回调
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];//删除激活界面的回调
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//rtmp status delegate:
- (void) LiveConnectionStatusChanged: (LIVE_VCSessionState) sessionState{
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (sessionState) {
            case LIVE_VCSessionStatePreviewStarted:
                break;
            case LIVE_VCSessionStateStarting:
                break;
            case LIVE_VCSessionStateStarted:
                break;
            case LIVE_VCSessionStateEnded:
                break;
            case LIVE_VCSessionStateError:
                break;
            default:
                break;
        }
    });
}




@end
