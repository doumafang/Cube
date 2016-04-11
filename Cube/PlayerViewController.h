//
//  PlayerViewController.h
//  Cube
//
//  Created by doumaaaaaaaa on 16/4/11.
//  Copyright © 2016年 doumafang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveVideoCoreSDK.h"

@interface PlayerViewController : UIViewController<LIVEVCSessionDelegate>
@property NSURL *rtmpURL;
@end
