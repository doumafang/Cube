//
//  Constans.swift
//  Cube
//
//  Created by doumaaaaaaaa on 16/4/10.
//  Copyright © 2016年 doumafang. All rights reserved.
//

import Foundation


public let kNavigationH = 64
/* 工具栏高度 */
public let kTabBarHeight = 49
/* 屏幕的宽 */
public let kSCREEN_WIDTH  = UIScreen.mainScreen().bounds.size.width
/* 屏幕的高 */
public let kSCREEN_HEIGHT  = UIScreen.mainScreen().bounds.size.height
/* 屏幕的宽 */
public let kMAIN_BOUNDS: CGRect = UIScreen.mainScreen().bounds
//public let kRTMPURL = NSURL(string: "rtmp://107.170.204.29:1935/cube/2")!
//public let kRTMPURL = NSURL(string: "rtmp://192.168.150.1:1935/live/1")!
//public let kRTMPURL = NSURL(string: "rtmp://192.168.191.2:1935/cube/2")!
public let kRTMPURL = NSURL(string: "rtmp://169.254.211.166:1935/cube/2")!


func KIfIPhone () -> (Bool)
{
    if (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {
        return true
    }
    
    else{
        return false
    }
}